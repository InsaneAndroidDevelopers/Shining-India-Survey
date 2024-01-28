import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/repository/create_update_surveyor_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'create_update_surveyor_event.dart';
part 'create_update_surveyor_state.dart';

class CreateUpdateSurveyorBloc extends Bloc<CreateUpdateSurveyorEvent, CreateUpdateSurveyorState> {
  CreateUpdateSurveyorBloc() : super(CreateUpdateSurveyorInitial()) {

    final CreateUpdateSurveyorRepository createUpdateSurveyorRepository = CreateUpdateSurveyorRepository();

    on<GetAllTeamsData>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {
        final teams = await createUpdateSurveyorRepository.getAllTeams();
        emit(AllTeamsFetchedState(teams: teams));
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
      }
    });

    on<CreateTeam>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {
        final bool isTeamCreated = await createUpdateSurveyorRepository.createTeam(teamName: event.teamName);
        if(isTeamCreated) {
          emit(TeamCreatedSuccessState());
          add(GetAllTeamsData());
        } else {
          emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
        }
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
      }
    });

    on<CreateSurveyor>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {
        final String id = await createUpdateSurveyorRepository.createSurveyor(
            name: event.name,
            email: event.email,
            password: event.password
        );
        if(id.isNotEmpty) {
          add(AddSurveyorIntoTeam(teamId: event.teamId, surveyorId: id));
        } else {
          emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
        }
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<AddSurveyorIntoTeam>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {
        final bool isSurveyorAdded = await createUpdateSurveyorRepository.addSurveyorIntoTeam(
          surveyorId: event.surveyorId,
          teamId: event.teamId
        );
        if(isSurveyorAdded) {
          emit(SurveyorAddedState());
        } else {
          emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
        }
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });



    on<RemoveSurveyor>((event, emit) async {
      emit(CreateUpdateSurveyorLoading());
      try {
        final isDeleted = await createUpdateSurveyorRepository.removeSurveyor(teamId: event.teamId, surveyorId: event.surveyorId);
        if(isDeleted) {
          emit(SurveyorDeletedState());
        } else {
          emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
        }
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });

    on<UpdateSurveyor>((event, emit) async {
      try {
        final isUpdated = await createUpdateSurveyorRepository.updateSurveyorStatus(isActive: event.isActive, surveyorId: event.surveyorId, password: event.password);
        if(isUpdated) {
          emit(SurveyorUpdatedState());
        } else {
          emit(CreateUpdateSurveyorError(message: 'Something went wrong'));
        }
      } on AppExceptionDio catch(e) {
        emit(CreateUpdateSurveyorError(message: e.message));
      } on DioException catch(e) {
        emit(CreateUpdateSurveyorError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(CreateUpdateSurveyorError(message: e.toString()));
      }
    });
  }
}
