import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shining_india_survey/models/question.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_response.dart';
import 'package:shining_india_survey/modules/survey/core/repository/survey_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';
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
      } on AppExceptionDio catch(e) {
        emit(SurveyErrorState(message: e.message));
      } on DioException catch(e) {
        emit(SurveyErrorState(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyErrorState(message: 'Something went wrong'));
      }
    });

    on<SubmitDetailsAndStartSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());

      //final questionsList = await surveyRepository.getSurveyQuestions(event.placeType);

      surveyResponseModel.locationModel = event.locationModel;
      surveyResponseModel.age = event.age;
      surveyResponseModel.name = event.name;
      surveyResponseModel.gender = event.gender;
      surveyResponseModel.latitude = event.latitude;
      surveyResponseModel.longitude = event.longitude;

      add(LoadFetchedDataEvent());

      emit(SurveyDataFetchedState());
    });

    on<LoadFetchedDataEvent>((event, emit)  {
      emit(SurveyLoadingState());

      //fetch data from API
      quesList.clear();
      for (var element in ques) {
        quesList.add(
          Question(
            id: element.id,
            questionText: element.questionText,
            options: element.options,
            type: element.type
          )
        );
      }
      surveyResponseModel.questionResponses = List.generate(quesList.length, (index) => QuestionResponseModel());

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
          emit(SurveyErrorState(message: 'Please select to proceed'));
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
          emit(SurveyErrorState(message: 'Please select to proceed'));
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
