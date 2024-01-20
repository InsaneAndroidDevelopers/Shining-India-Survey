part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();
}

class AnalysisInitial extends AnalysisState {
  @override
  List<Object> get props => [];
}

class AnalysisLoading extends AnalysisState {
  @override
  List<Object> get props => [];
}

class AnalysisSuccess extends AnalysisState {
  final List<AnalysisResponseModel> analysisList;
  const AnalysisSuccess({required this.analysisList});

  @override
  List<Object> get props => [];
}

class AnalysisError extends AnalysisState {
  final String message;
  const AnalysisError({required this.message});

  @override
  List<Object> get props => [];
}

class AnalysisPdfLoading extends AnalysisState {
  @override
  List<Object> get props => [];
}
