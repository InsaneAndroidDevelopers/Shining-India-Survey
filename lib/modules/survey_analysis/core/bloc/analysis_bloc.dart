import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/chart_data_model.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/repository/analysis_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    final AnalysisRepository analysisRepository = AnalysisRepository();

    on<GetAllAnalysis>((event, emit) async {
      emit(AnalysisLoading());
      try {
        final analysisList = await analysisRepository.getAnalysis();
        emit(AnalysisSuccess(analysisList: analysisList));
      } on AppExceptionDio catch(e) {
        emit(AnalysisError(message: e.message));
      } on DioException catch(e) {
        emit(const AnalysisError(message: 'Something went wrong'));
      } catch(e) {
        emit(AnalysisError(message: e.toString()));
      }
    });

    on<GetFilteredAnalysis>((event, emit) async {
      emit(AnalysisLoading());
      try {
        final analysisList = await analysisRepository.getFilteredAnalysis(
          teamId: event.teamId,
          gender: event.gender,
          fromDate: event.fromDate,
          toDate: event.toDate,
          minAge: event.minAge,
          maxAge: event.maxAge,
          state: event.state
        );
        emit(AnalysisSuccess(analysisList: analysisList));
      } on AppExceptionDio catch(e) {
        emit(AnalysisError(message: e.message));
      } on DioException catch(e) {
        emit(const AnalysisError(message: 'Something went wrong'));
      } catch(e) {
        emit(AnalysisError(message: e.toString()));
      }
    });
  }
}