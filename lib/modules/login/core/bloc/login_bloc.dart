import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shining_india_survey/helpers/hive_db_helper.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/login/core/models/admin_response_model.dart';
import 'package:shining_india_survey/modules/login/core/models/surveyor_response_model.dart';
import 'package:shining_india_survey/modules/login/core/repository/login_repository.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/utils/exceptions.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    final LoginRepository loginRepository = LoginRepository();

    on<AdminLoginEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final AdminResponseModel adminResponseModel = await loginRepository
            .adminLogin(
            email: event.email,
            password: event.password
        );
        await SharedPreferencesHelper.setUserId(adminResponseModel.id ?? '');
        await SharedPreferencesHelper.setUserName(adminResponseModel.name ?? '');
        await SharedPreferencesHelper.setUserLevel(StringsConstants.ADMIN);

        add(GetAndSaveQuestions());

        emit(AdminLoginSuccessState());
      } on AppExceptionDio catch(e) {
        emit(ErrorState(message: e.message));
      } on DioException catch(e) {
        emit(ErrorState(message: e.response?.data != null ?  'Something went wrong' : e.response?.data['error']));
      } catch(e) {
        emit(const ErrorState(message: 'Some error occurred'));
      }
    });

    on<SurveyorLoginEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final SurveyorResponseModel surveyorResponseModel = await loginRepository
            .surveyorLogin(
            email: event.email,
            password: event.password
        );
        await SharedPreferencesHelper.setUserId(surveyorResponseModel.id ?? '');
        await SharedPreferencesHelper.setUserName(surveyorResponseModel.name ?? '');
        await SharedPreferencesHelper.setUserTeamId(surveyorResponseModel.teamId ?? '');
        await SharedPreferencesHelper.setUserLevel(StringsConstants.SURVEYOR);

        add(GetAndSaveQuestions());

        emit(SurveyorLoginSuccessState());
      } on AppExceptionDio catch(e) {
        emit(ErrorState(message: e.message));
      } on DioException catch(e) {
        emit(ErrorState(message: e.response?.data != null ?  'Something went wrong' : e.response?.data['error']));
      } catch(e) {
        emit(const ErrorState(message: 'Something went wrong'));
      }
    });

    on<GetAndSaveQuestions>((event, emit) async {
      List<QuestionModel> list = [];
      try {
        list = await loginRepository.getSurveyQuestions(placeType: 'rural');
        Map<String, String> questionWithIds = {};
        for(var item in list) {
          questionWithIds[item.id ?? ''] = item.question ?? '';
        }
        await HiveDbHelper.insertData(questionWithIds);
      } on AppExceptionDio catch(e) {
        emit(ErrorState(message: e.message));
      } on DioException catch(e) {
        emit(ErrorState(message: e.response?.data != null ?  'Something went wrong' : e.response?.data['error']));
      } catch(e) {
        emit(const ErrorState(message: 'Something went wrong'));
      }
    });
  }
}
