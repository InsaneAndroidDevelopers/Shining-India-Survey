import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/splash/core/bloc/splash_bloc.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/recent_survey_model.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/repository/surveyor_home_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'surveyor_home_event.dart';
part 'surveyor_home_state.dart';

class SurveyorHomeBloc extends Bloc<SurveyorHomeEvent, SurveyorHomeState> {
  SurveyorHomeBloc() : super(SurveyorHomeInitial()) {

    final SurveyorHomeRepository surveyorHomeRepository = SurveyorHomeRepository();

    on<GetRecentSurveys>((event, emit) async {
      emit(SurveyorHomeLoadingState());
      try{
        final List<RecentSurveyModel> surveys = await surveyorHomeRepository.getRecentSurveys();
        emit(SurveyorHomeFetchedState(surveys: surveys));
      } on AppExceptionDio catch(e) {
        emit(SurveyorHomeErrorState(message: e.message));
      } on DioException catch(e) {
        emit(const SurveyorHomeErrorState(message: 'Something went wrong'));
      } catch(e) {
        emit(SurveyorHomeErrorState(message: e.toString()));
      }
    });

    on<SurveyorLogout>((event, emit) async {
      emit(SurveyorLogoutLoadingState());
      try{
        final bool isLoggedOut = await surveyorHomeRepository.surveyorLogout();
        if(isLoggedOut) {
          await SharedPreferencesHelper.clearAll();
          emit(SurveyorLogoutSuccessState());
        }
      } on AppExceptionDio catch(e) {
        emit(SurveyorLogoutErrorState(message: e.message));
      } on DioException catch(e) {
        emit(SurveyorLogoutErrorState(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyorLogoutErrorState(message: e.toString()));
      }
    });

    on<GetSurveyorInfo>((event, emit) async {
      final name = await SharedPreferencesHelper.getUserName();
      emit(SurveyorHomeInfoFetchedState(name: name));
    });
  }
}
