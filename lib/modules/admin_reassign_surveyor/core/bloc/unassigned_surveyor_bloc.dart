import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/modules/admin_reassign_surveyor/core/model/unassigned_surveyor_model.dart';
import 'package:shining_india_survey/modules/admin_reassign_surveyor/core/respository/surveyor_unassigned_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'unassigned_surveyor_event.dart';
part 'unassigned_surveyor_state.dart';

class UnassignedSurveyorBloc extends Bloc<UnassignedSurveyorEvent, UnassignedSurveyorState> {
  UnassignedSurveyorBloc() : super(UnassignedSurveyorInitial()) {
    final unassignedSurveyorRepository = SurveyorUnassignedRepository();

    on<FetchAllUnassignedSurveyors>((event, emit) async {
      emit(UnassignedSurveyorLoading());
      try {
        final list = await unassignedSurveyorRepository.getAllUnassignedSurveyors();
        emit(UnassignedSurveyorsFetched(list: list));
      } on AppExceptionDio catch(e) {
        emit(UnassignedSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(UnassignedSurveyorError(message: 'Something went wrong'));
      } catch(e) {
        emit(UnassignedSurveyorError(message: 'Something went wrong'));
      }
    });
  }
}
