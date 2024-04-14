import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/repository/filled_survey_repository.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

part 'filled_survey_event.dart';
part 'filled_survey_state.dart';

class FilledSurveyBloc extends Bloc<FilledSurveyEvent, FilledSurveyState> {
  bool isFetchingAll = false;
  bool isFetchingFilter = false;
  FilledSurveyBloc() : super(const FilledSurveyInitial()) {

    final FilledSurveyRepository filledSurveyRepository = FilledSurveyRepository();
    int pageAll = 0;
    int pageFilter = 0;
    bool hasMorePagesAll = true;
    bool hasMorePagesFilter = true;

    on<FetchAllSurveys>((event, emit) async {
      emit(FilledSurveyLoading());
      try {
        if(event.isFirstFetch == true) {
          pageAll = 0;
          hasMorePagesAll = true;
        }

        List<SurveyResponseModel> list = [];
        if(hasMorePagesAll) {
          list = await filledSurveyRepository.getAllSurveys(page: pageAll);
        }

        if(list.isEmpty) {
          hasMorePagesAll = false;
        } else {
          pageAll++;
        }

        emit(FilledSurveyFetched(list: list));
      } on AppExceptionDio catch(e) {
        emit(FilledSurveyError(message: e.message));
      } on DioException catch(e) {
        emit(FilledSurveyError(message: e.response?.data != null ?  'Something went wrong' : e.response?.data['error']));
      } catch(e) {
        emit(FilledSurveyError(message: 'Something went wrong'));
      }
    });

    on<FilterSurveys>((event, emit) async {
      emit(FilterSurveysLoading());
      try {
        if(event.isFirstFetch == true) {
          pageFilter = 0;
          hasMorePagesFilter = true;
        }

        List<SurveyResponseModel> list = [];
        if(hasMorePagesFilter) {
          list = await filledSurveyRepository.getFilteredSurveys(
              teamId: event.teamId,
              gender: event.gender,
              minAge: event.minAge,
              maxAge: event.maxAge,
              fromDate: event.fromDate,
              toDate: event.toDate,
              page: pageFilter,
              state: event.state
          );
        }

        if(list.isEmpty) {
          hasMorePagesFilter = false;
        } else {
          pageFilter++;
        }

        emit(FilterSurveysFetched(filterList: list, isFirstFetch: event.isFirstFetch));
      } on AppExceptionDio catch(e) {
        emit(FilledSurveyError(message: e.message));
      } on DioException catch(e) {
        emit(FilledSurveyError(message: e.response?.data['error'] ?? 'Something went wrong'));
      } catch(e) {
        emit(const FilledSurveyError(message: 'Something went wrong'));
      }
    });
  }
}
