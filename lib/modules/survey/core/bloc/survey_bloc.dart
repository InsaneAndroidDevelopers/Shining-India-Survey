import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shining_india_survey/models/question.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_response.dart';
import 'package:shining_india_survey/modules/survey/core/repository/survey_repository.dart';
import 'package:shining_india_survey/utils/string_constants.dart';

import '../models/survey_response_model.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {

  SurveyBloc() : super(SurveyInitial()) {

    final SurveyRepository surveyRepository = SurveyRepository();
    List<Question> quesList = [];
    SurveyResponseModel surveyResponseModel = SurveyResponseModel();

    void updateResponse() {
      surveyResponseModel.questionResponses = quesList.map((e){
        return QuestionResponseModel(
            id: e.id,
            selectedIndex: e.selectedIndex,
            selectedOptionsIndex: e.selectedOptions,
            othersText: e.otherText
        );
      }).toList();
    }

    on<FetchLocationFromLatLngEvent>((event, emit) async {
      emit(SurveyLoadingState());
      try {
        final LocationModel locationModel = await surveyRepository.getAddressFromLatLng(event.latitude, event.longitude);
        emit(SurveyLocationFetchedState(
            pinCode: locationModel.postcode ?? '',
            village: locationModel.village ?? '',
            district: locationModel.stateDistrict ?? '',
            state: locationModel.state ?? ''
          )
        );
      } catch(e) {
        emit(SurveyErrorState());
      }
    });

    on<SubmitDetailsAndStartSurveyEvent>((event, emit) {
      emit(SurveyLoadingState());

      //save and fetch the data from the API and set the length of the question

      quesList = ques;
      surveyResponseModel.questionResponses = List.generate(quesList.length, (index) => QuestionResponseModel());

      surveyResponseModel.locationModel = event.locationModel;
      surveyResponseModel.age = event.age;
      surveyResponseModel.name = event.name;
      surveyResponseModel.gender = event.gender;
      surveyResponseModel.latitude = event.latitude;
      surveyResponseModel.longitude = event.longitude;

      emit(SurveyDataFetchedState());
    });

    on<LoadFetchedDataEvent>((event, emit)  {
      emit(SurveyLoadingState());

      emit(SurveyDataLoadedState(questions: quesList));
    });

    on<CheckQuestionResponseEvent>((event, emit) async {
      Question question = event.question;
      int currentIndex = event.index;
      print("Index - ${event.index}");
      print(question.selectedOptions.toString());
      print(question.selectedIndex);
      if(question.type == StringsConstants.QUES_TYPE_MULTI) {
        if(question.selectedOptions.contains(1) || question.otherText.isNotEmpty) {
          if(currentIndex == quesList.length - 1) {
            updateResponse();
            emit(SurveyFinishState());
          } else {
            emit(SurveyMoveNextQuestionState(index: currentIndex++));
          }
        } else {
          emit(SurveyErrorState());
        }
      } else if(question.type == StringsConstants.QUES_TYPE_SINGLE) {
        if(question.selectedIndex != -1) {
          if(currentIndex == quesList.length - 1) {
            updateResponse();
            emit(SurveyFinishState());
          } else {
            emit(SurveyMoveNextQuestionState(index: currentIndex++));
          }
        } else {
          emit(SurveyErrorState());
        }
      } else if(question.type == StringsConstants.QUES_TYPE_SLIDER) {
        if(currentIndex == quesList.length - 1) {
          updateResponse();
          emit(SurveyFinishState());
        } else {
          emit(SurveyMoveNextQuestionState(index: currentIndex++));
        }
      }
    });

    on<SubmitAdditionalDetailsAndFinishEvent>((event, emit) {
      emit(SurveyLoadingState());

      surveyResponseModel.phone = event.phone;
      surveyResponseModel.address = event.address;
      surveyResponseModel.religion = event.religion;
      surveyResponseModel.caste = event.caste;

      debugPrint(surveyResponseModel.toJson().toString());

      emit(SurveySuccessState());
    });

    on<SkipAndFinishSurveyEvent>((event, emit) {
      emit(SurveyLoadingState());
      //send the response to the API
      emit(SurveySuccessState());
    });
  }
}
