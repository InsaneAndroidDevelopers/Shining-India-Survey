import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/login/core/models/admin_response_model.dart';
import 'package:shining_india_survey/modules/login/core/models/surveyor_response_model.dart';
import 'package:shining_india_survey/modules/login/core/repository/login_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';
import 'package:shining_india_survey/utils/string_constants.dart';

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
        await SharedPreferencesHelper.setUserLevel(StringsConstants.ADMIN);
        emit(AdminLoginSuccessState());
      } on AppExceptionDio catch(e) {
        emit(ErrorState(message: e.message));
      } on DioException catch(e) {
        print(e.stackTrace.toString());
        emit(ErrorState(message: e.message ?? 'Please try again'));
      } catch(e) {
        emit(const ErrorState(message: 'Some error occurred'));
      }
    });

    on<SurveyorLoginEvent>((event, emit) async {
      emit(LoadingState());
      try {
        print('email -- ${event.email} password -- ${event.password}');
        final SurveyorResponseModel surveyorResponseModel = await loginRepository
            .surveyorLogin(
            email: event.email,
            password: event.password
        );
        await SharedPreferencesHelper.setUserId(surveyorResponseModel.id ?? '');
        await SharedPreferencesHelper.setUserLevel(StringsConstants.SURVEYOR);
        emit(SurveyorLoginSuccessState());
      } on AppExceptionDio catch(e) {
        emit(ErrorState(message: e.message));
      } on DioException catch(e) {
        emit(ErrorState(message: e.message ?? 'Please try again'));
      } catch(e) {
        emit(const ErrorState(message: 'Some error occurred'));
      }
    });
  }
}
