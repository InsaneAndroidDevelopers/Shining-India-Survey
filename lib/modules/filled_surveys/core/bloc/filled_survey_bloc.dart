import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/repository/filled_survey_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'filled_survey_event.dart';
part 'filled_survey_state.dart';

class FilledSurveyBloc extends Bloc<FilledSurveyEvent, FilledSurveyState> {
  FilledSurveyBloc() : super(FilledSurveyInitial()) {

    final FilledSurveyRepository filledSurveyRepository = FilledSurveyRepository();
    int page = 0;

    on<FetchAllSurveys>((event, emit) async {
      if(state is FilledSurveyLoading) {
        return;
      }

      final currentState = state;
      var oldLists = <SurveyResponseModel>[];
      if(currentState is FilledSurveyFetched) {
        oldLists = currentState.list;
      }

      emit(FilledSurveyLoading(oldList: oldLists, isFirstFetch: page == 0));
      
      await filledSurveyRepository.getAllSurveys(page: page).then((value){
        page++;
        final newLists = (state as FilledSurveyLoading).oldList;
        newLists.addAll(value);
        emit(FilledSurveyFetched(list: newLists));
      });

      // emit(FilledSurveyLoading(null));
      // try {
      //   final surveys = await filledSurveyRepository.getAllSurveys(page: page);
      //   emit(FilledSurveyFetched(surveys: surveys));
      // } on AppExceptionDio catch(e) {
      //   emit(FilledSurveyError(null, message: e.message));
      // } on DioException catch(e) {
      //   emit(FilledSurveyError(null, message: e.message ?? 'Something went wrong'));
      // } catch(e) {
      //   emit(const FilledSurveyError(null, message: 'Something went wrong'));
      // }
    });


    //
    // on<FetchMoreSurveys>((event, emit) async {
    //   emit(FilledSurveyLoading(null));
    //   try {
    //     page++;
    //     final surveys = await filledSurveyRepository.getAllSurveys(page: page);
    //     emit(FilledSurveyFetched(surveys: [...state.surveys, ...surveys]));
    //   } on AppExceptionDio catch(e) {
    //     emit(FilledSurveyError(null, message: e.message));
    //   } on DioException catch(e) {
    //     emit(FilledSurveyError(null, message: e.message ?? 'Something went wrong'));
    //   } catch(e) {
    //     emit(const FilledSurveyError(null, message: 'Something went wrong'));
    //   }
    // });
  }
}
