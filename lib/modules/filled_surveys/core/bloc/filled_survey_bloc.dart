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
  FilledSurveyBloc() : super(FilledSurveyInitial()) {

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
        emit(FilledSurveyError(message: 'Something went wrong'));
      } catch(e) {
        emit(FilledSurveyError(message: 'Something went wrong'));
      }
    });

    on<FilterSurveys>((event, emit) async {
      emit(FilterSurveysLoading());
      try {
        if(event.isFirstFetch == true) {
          pageFilter = 0;
        }

        List<SurveyResponseModel> list = [];
        if(hasMorePagesFilter) {
          list = await filledSurveyRepository.getFilteredSurveys(
              teamId: event.teamId,
              gender: event.gender,
              fromDate: event.fromDate,
              toDate: event.toDate,
              page: pageFilter
          );
        }

        if(list.isEmpty) {
          hasMorePagesFilter = false;
        } else {
          pageFilter++;
        }

        emit(FilterSurveysFetched(filterList: list));
      } on AppExceptionDio catch(e) {
        emit(FilledSurveyError(message: e.message));
      } on DioException catch(e) {
        emit(FilledSurveyError(message: 'Something went wrong'));
      } catch(e) {
        emit(const FilledSurveyError(message: 'Something went wrong'));
      }
    });
  }
}
