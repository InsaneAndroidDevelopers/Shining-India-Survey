part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();
}

class GetAllAnalysis extends AnalysisEvent {
  @override
  List<Object?> get props => [];
}

class GetFilteredAnalysis extends AnalysisEvent {
  final String gender;
  final String fromDate;
  final String toDate;
  final int minAge;
  final int maxAge;
  final String teamId;
  final String state;

  const GetFilteredAnalysis({
    required this.toDate,
    required this.fromDate,
    required this.maxAge,
    required this.minAge,
    required this.teamId,
    required this.gender,
    required this.state
  });

  @override
  List<Object?> get props => [];
}

class GeneratePdfFile extends AnalysisEvent {
  final List<AnalysisResponseModel> analysisList;
  final List<Uint8List> images;
  const GeneratePdfFile({required this.analysisList, required this.images});

  @override
  List<Object?> get props => [];
}
