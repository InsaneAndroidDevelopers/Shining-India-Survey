import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/repository/create_update_surveyor_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'create_update_surveyor_event.dart';
part 'create_update_surveyor_state.dart';

class CreateUpdateSurveyorBloc extends Bloc<CreateUpdateSurveyorEvent, CreateUpdateSurveyorState> {
  CreateUpdateSurveyorBloc() : super(CreateUpdateSurveyorInitial()) {

    final CreateUpdateSurveyorRepository createUpdateSurveyorRepository = CreateUpdateSurveyorRepository();

    on<GetAllTeamsData>((event, emit) {
      emit(CreateUpdateSurveyorLoading());
      try {

        emit(AllTeamsFetchedState());
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<CreateTeam>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {

        emit(TeamCreatedSuccessState());
        add(GetAllTeamsData());
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<CreateSurveyor>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {


        add(GetAllTeamsData());
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<RemoveSurveyor>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {


      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<UpdateSurveyor>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {


        add(GetAllTeamsData());
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });
  }
}
