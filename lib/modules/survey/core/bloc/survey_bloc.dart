import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shining_india_survey/models/question.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {

  int activeIndex = 0;
  List<Question> quesList = [];
  String othersText = "";
  List<int> selectedOptionsList = [];
  int selectedOptionIndex = -1;

  SurveyBloc() : super(SurveyInitial()) {

    on<SubmitDetailsAndStartSurveyEvent>((event, emit) {
      emit(SurveyLoadingState());
      //save and fetch the data from the API and set the length of the question
      quesList = ques;
      emit(SurveyDataFetchedState());
    });

    on<LoadFetchedDataEvent>((event, emit)  {
      emit(SurveyLoadingState());
      emit(SurveyDataLoadedState(questions: ques));
    });



    on<GetSelectedOptionsDetailsEvent>((event, emit) async {
      othersText = event.othersText ?? "";
      selectedOptionsList = event.selectedOptionsIndex ?? [];
      selectedOptionIndex = event.selectedIndex ?? -1;

    });

    on<CheckQuestionResponseEvent>((event, emit) async {
      emit(SurveyCheckCurrentResponseState());
      await Future.delayed(Duration(seconds: 2));
      if(quesList[activeIndex].answer.isEmpty){
        emit(SurveyErrorState());
      } else {
        if(activeIndex == quesList.length - 1){
          activeIndex = 0;
          emit(SurveyFinishState());
        } else {
          activeIndex++;
          emit(SurveyMoveNextQuestionState(index: activeIndex));
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

  Future updateDetails(int selectedIndex, List<int> selectedOptionsIndex, String others) async {

    selectedOptionIndex = selectedIndex;
    selectedOptionsList = selectedOptionsIndex;
    othersText = others;
  }

  Future updateAnswerList(List<int> ansList, String others) async{
    String answer = "";
    for(int i=0; i<ansList.length; i++) {
      if(ansList[i] == 1) {
        answer += quesList[activeIndex].options[i];
        answer += ",";
      }
    }
    if(answer.isNotEmpty && others.isEmpty) {
      answer = answer.substring(0, answer.length-1);
    } else {
       answer += others;
    }
    quesList[activeIndex].answer = answer;
  }

  Future updateAnswer(int index) async {
    quesList[activeIndex].answer = quesList[activeIndex].options[index];
  }

  Future updateAnswerFunc({
    required bool isMultiCorrect,
    List<int>? selectedOptionsList,
    int? selectedOptionIndex,
    String? othersOptionText
  }) async {
    if(isMultiCorrect) {
      String finalAnswer = "";
      int length = selectedOptionsList?.length ?? 0;
      for(int i=0; i<length; i++) {
        if(selectedOptionsList?[i] == 1) {
          finalAnswer += quesList[activeIndex].options[i];
          finalAnswer += ",";
        }
      }
      if(finalAnswer.isNotEmpty && othersOptionText == null) {
        finalAnswer = finalAnswer.substring(0, finalAnswer.length-1);
      } else {
        finalAnswer += othersOptionText ?? "";
      }
      quesList[activeIndex].answer = finalAnswer;
    } else {
      int ind = selectedOptionIndex ?? 0;
      quesList[activeIndex].answer = quesList[activeIndex].options[ind];
    }
  }
}
