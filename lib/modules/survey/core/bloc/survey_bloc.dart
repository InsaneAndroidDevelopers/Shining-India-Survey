import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shining_india_survey/models/question.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {

  int quesLength = 0;
  int activePage = 0;
  List<String> answers = [];

  SurveyBloc() : super(SurveyInitial()) {

    on<SubmitDetailsAndStartSurveyEvent>((event, emit) {
      emit(SurveyLoadingState());
      //save and fetch the data from the API and set the length of the question
      quesLength = 5;
      answers = List.generate(quesLength, (index) => '');
      emit(SurveyDataFetchedState());
      print(answers.length);
    });

    on<LoadFetchedDataEvent>((event, emit) async {
      emit(SurveyLoadingState());

      emit(SurveyDataLoadedState(questions: ques));
    });

    on<CheckQuestionResponseEvent>((event, emit) async {
      if(answers[activePage].isEmpty){
        emit(SurveyErrorState());
      } else {
        if(activePage == quesLength-1){
          activePage = 0;
          emit(SurveyFinishState());
        } else {
          activePage++;
          emit(SurveyMoveNextQuestionState(index: activePage));
        }
      }
    });

    on<SubmitAdditionalDetailsAndFinishEvent>((event, emit) {
      emit(SurveyLoadingState());
      //save and send the response to the API and move forward
      emit(SurveySuccessState());
    });

    on<SkipAndFinishSurveyEvent>((event, emit) {
      emit(SurveyLoadingState());
      //send the response to the API
      emit(SurveySuccessState());
    });
  }
}
