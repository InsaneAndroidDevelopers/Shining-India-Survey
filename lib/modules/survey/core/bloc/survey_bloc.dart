import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/survey_submit_model.dart';
import 'package:shining_india_survey/modules/survey/core/repository/survey_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {

  SurveyBloc() : super(SurveyInitial()) {

    final SurveyRepository surveyRepository = SurveyRepository();
    List<QuestionModel> quesList = [];
    SurveySubmitModel surveySubmitModel = SurveySubmitModel();

    void updateResponse() {
      surveySubmitModel.response = quesList.map((e) {
        List<String> answers = [];
        if(e.type == StringsConstants.QUES_TYPE_MULTI) {
          for(int i=0; i<e.selectedOptions.length; i++) {
            if(e.selectedOptions[i] == 1) {
              answers.add(e.options?[i] ?? '');
            }
          }
          if(e.otherText.isNotEmpty) {
            answers.add('_${e.otherText}');
          }
        } else if(e.type == StringsConstants.QUES_TYPE_SINGLE) {
          if(e.selectedIndex != -1) {
            answers.add(e.options?[e.selectedIndex] ?? '');
            if(e.otherText.isNotEmpty) {
              answers.add('_${e.otherText}');
            }
          }
        } else if(e.type == StringsConstants.QUES_TYPE_SLIDER) {
          if(e.selectedIndex != -1) {
            answers.add(e.options?[e.selectedIndex] ?? '');
            if(e.otherText.isNotEmpty) {
              answers.add('_${e.otherText}');
            }
          }
        }
        return QuestionResponse(
          questionId: e.id,
          answer: answers
        );
      }).toList();
    }

    on<FetchLocationFromLatLngEvent>((event, emit) async {
      emit(SurveyLocationLoadingState());
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
        emit(SurveyErrorState(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyErrorState(message: 'Something went wrong'));
      }
    });

    on<SubmitDetailsAndStartSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());
      final userName = await SharedPreferencesHelper.getUserName();
      final teamId = await SharedPreferencesHelper.getUserTeamId();
      try {
        final listFromApi = await surveyRepository.getSurveyQuestions(placeType: event.placeType);

        surveySubmitModel.username = userName;
        surveySubmitModel.teamID = teamId;
        surveySubmitModel.country = event.locationModel.country;
        surveySubmitModel.assemblyName = event.assemblyName;
        surveySubmitModel.surveyDateTime = event.dateTime;
        surveySubmitModel.personName = event.name;
        surveySubmitModel.gender = event.gender;
        surveySubmitModel.age = event.age;
        surveySubmitModel.latitude = event.latitude.toString();
        surveySubmitModel.longitude = event.longitude.toString();
        surveySubmitModel.ward = event.locationModel.village;
        surveySubmitModel.city = event.city;
        surveySubmitModel.pincode = event.locationModel.postcode;
        surveySubmitModel.state = event.locationModel.state;
        surveySubmitModel.district = event.locationModel.stateDistrict;

        add(LoadFetchedDataEvent(list: listFromApi));

        emit(SurveyDataFetchedState());
      } on AppExceptionDio catch(e) {
        emit(SurveyErrorState(message: e.message));
      } on DioException catch(e) {
        emit(SurveyErrorState(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyErrorState(message: 'Something went wrong'));
      }
    });

    on<LoadFetchedDataEvent>((event, emit)  {
      quesList.clear();
      for (var element in event.list) {
        quesList.add(
          QuestionModel(
            id: element.id,
            question: element.question,
            options: element.options,
            type: element.type,
            other: element.other
          )
        );
      }
      surveySubmitModel.response = List.generate(quesList.length, (index) => QuestionResponse());
      emit(SurveyDataLoadedState(questions: quesList));
    });

    on<CheckQuestionResponseEvent>((event, emit) async {
      QuestionModel question = event.question;
      int currentIndex = event.index;
      print("Index - ${event.index}");
      print(question.selectedOptions.toString());
      print(question.selectedIndex);
      print(question.otherText);
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

    on<SkipQuestionEvent>((event, emit) {
      int currentIndex = event.index;
      if(currentIndex == quesList.length - 1) {
        updateResponse();
        emit(SurveyFinishState());
      }
      emit(SurveyMoveNextQuestionState(index: currentIndex++));
    });

    on<SubmitAdditionalDetailsAndFinishEvent>((event, emit) async {
      emit(SurveyLoadingState());
      surveySubmitModel.mobileNum = event.mobileNum;
      surveySubmitModel.address = event.address;
      surveySubmitModel.religion = event.religion;
      surveySubmitModel.caste = event.caste;
      try {
        await surveyRepository.submitSurvey(surveySubmitModel: surveySubmitModel);
        debugPrint(surveySubmitModel.toJson().toString());
        emit(SurveySuccessState());
      } on AppExceptionDio catch(e) {
        emit(SurveyErrorState(message: e.message));
      } on DioException catch(e) {
        emit(SurveyErrorState(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyErrorState(message: e.toString()));
      }
    });

    on<SkipAndFinishSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());
      try {
        await surveyRepository.submitSurvey(surveySubmitModel: surveySubmitModel);
        debugPrint(surveySubmitModel.toJson().toString());
        emit(SurveySuccessState());
      } on AppExceptionDio catch(e) {
        emit(SurveyErrorState(message: e.message));
      } on DioException catch(e) {
        emit(SurveyErrorState(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(SurveyErrorState(message: e.toString()));
      }
    });
  }
}
