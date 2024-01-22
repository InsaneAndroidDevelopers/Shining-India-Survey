import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_india_survey/global/methods/get_gender.dart';
import 'package:shining_india_survey/global/methods/get_min_max_age.dart';
import 'package:shining_india_survey/global/methods/get_timestamp_from_date.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/filled_survey_holder.dart';

class SurveyListWidget extends StatefulWidget {
  final List<SurveyResponseModel> list;
  final bool isFilter;
  final ValueNotifier<int> genderIndex;
  final ValueNotifier<int> ageIndex;
  final String? teamId;
  final String? state;
  final ValueNotifier<int> dateIndex;
  const SurveyListWidget({super.key, required this.isFilter, required this.list, required this.genderIndex, required this.ageIndex, this.teamId, required this.dateIndex, this.state});

  @override
  State<SurveyListWidget> createState() => _SurveyListWidgetState();
}

class _SurveyListWidgetState extends State<SurveyListWidget> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(scrollController.position.maxScrollExtent == 0){
        if(widget.isFilter) {
          if(!BlocProvider.of<FilledSurveyBloc>(context).isFetchingFilter) {
            context.read<FilledSurveyBloc>()
              ..isFetchingFilter = true
              ..add(FilterSurveys(
                  gender: getGenderFromIndex(widget.genderIndex.value),
                  teamId: widget.teamId ?? '',
                  fromDate: getTimeStampFromDate(widget.dateIndex.value),
                  toDate: DateTime.now().toIso8601String(),
                  isFirstFetch: false,
                  minAge: getMinMaxAgeFromIndex(widget.ageIndex.value).minAge,
                  maxAge: getMinMaxAgeFromIndex(widget.ageIndex.value).maxAge,
                  state: widget.state ?? ''
                )
              );
          }
        } else {
          if(!BlocProvider.of<FilledSurveyBloc>(context).isFetchingAll) {
            context.read<FilledSurveyBloc>()
              ..isFetchingAll = true
              ..add(const FetchAllSurveys(isFirstFetch: false));
          }
        }
      }
    });

    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {

        if(widget.isFilter) {
          if(!BlocProvider.of<FilledSurveyBloc>(context).isFetchingFilter) {
            context.read<FilledSurveyBloc>()
              ..isFetchingFilter = true
              ..add(FilterSurveys(
                  gender: getGenderFromIndex(widget.genderIndex.value),
                  teamId: widget.teamId ?? '',
                  fromDate: getTimeStampFromDate(widget.dateIndex.value),
                  toDate: DateTime.now().toIso8601String(),
                  isFirstFetch: false,
                  minAge: getMinMaxAgeFromIndex(widget.ageIndex.value).minAge,
                  maxAge: getMinMaxAgeFromIndex(widget.ageIndex.value).maxAge,
                  state: widget.state ?? ''
                )
              );
          }
        } else {
          if(!BlocProvider.of<FilledSurveyBloc>(context).isFetchingAll) {
            context.read<FilledSurveyBloc>()
              ..isFetchingAll = true
              ..add(const FetchAllSurveys(isFirstFetch: false));
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index >=  widget.list.length) {
          Timer(const Duration(milliseconds: 30),
                  () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
          return const Center(
              child: CircularProgressIndicator());
        } else {
          return FilledSurveyHolder(
              surveyResponseModel:
              widget.list[index]);
        }
      },
      itemCount: widget.list.length + getExtraLength()
    );
  }

  int getExtraLength() {
    if(widget.isFilter) {
      return BlocProvider.of<FilledSurveyBloc>(context).isFetchingFilter ? 1 : 0;
    } else {
      return BlocProvider.of<FilledSurveyBloc>(context).isFetchingAll ? 1 : 0;
    }
  }
}
