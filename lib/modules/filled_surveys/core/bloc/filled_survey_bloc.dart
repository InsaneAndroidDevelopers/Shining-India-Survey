import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filled_survey_event.dart';
part 'filled_survey_state.dart';

class FilledSurveyBloc extends Bloc<FilledSurveyEvent, FilledSurveyState> {
  FilledSurveyBloc() : super(FilledSurveyInitial()) {
    on<FilledSurveyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
