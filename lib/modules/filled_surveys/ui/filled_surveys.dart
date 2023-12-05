import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/date_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/filled_survey_holder.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/recent_survey_model.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/widgets/recent_survey_holder.dart';

class AdminFilledSurveys extends StatefulWidget {
  const AdminFilledSurveys({super.key});

  @override
  State<AdminFilledSurveys> createState() => _AdminFilledSurveysState();
}

class _AdminFilledSurveysState extends State<AdminFilledSurveys> {
  String _dropDownStateValue = ArrayResources.states[0];
  String? teamId;

  ValueNotifier<bool> isVisible = ValueNotifier<bool>(false);

  final ScrollController scrollControllerAll = ScrollController();
  final ScrollController scrollControllerFilter = ScrollController();
  final List<SurveyResponseModel> _listAll = [];
  final List<SurveyResponseModel> _listFilter = [];
  ValueNotifier<bool> isFilterApplied = ValueNotifier(false);
  ValueNotifier<int> dateSelector = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context
        .read<FilledSurveyBloc>()
        .add(const FetchAllSurveys(isFirstFetch: true));
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());

    scrollControllerAll.addListener(() {
      if (scrollControllerAll.offset ==
              scrollControllerAll.position.maxScrollExtent &&
          !BlocProvider.of<FilledSurveyBloc>(context).isFetchingAll) {
        context.read<FilledSurveyBloc>()
          ..isFetchingAll = true
          ..add(const FetchAllSurveys(isFirstFetch: false));
      }
    });

    scrollControllerFilter.addListener(() {
      if (scrollControllerFilter.offset ==
              scrollControllerFilter.position.maxScrollExtent &&
          !BlocProvider.of<FilledSurveyBloc>(context).isFetchingFilter) {
        context.read<FilledSurveyBloc>()
          ..isFetchingFilter = true
          ..add(FilterSurveys(
              gender: 'Male',
              teamId: teamId ?? '',
              fromDate: getTimeStampFromDate(dateSelector.value),
              toDate: DateTime.now().toIso8601String(),
              isFirstFetch: false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightBlack),
        borderRadius: BorderRadius.circular(16));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                      onTap: () {
                        context.pop();
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'All Surveys',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isFilterApplied,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                        key: Key('uniqueKey'),
                        valueListenable: isVisible,
                        builder: (context, value, child) {
                          return Badge(
                            backgroundColor: isFilterApplied.value
                                ? Colors.red
                                : Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  if (isVisible.value == true) {
                                    isVisible.value = false;
                                  } else {
                                    isVisible.value = true;
                                  }
                                },
                                child: Icon(isVisible.value == true
                                    ? Icons.keyboard_arrow_down_rounded
                                    : Icons.keyboard_arrow_up_rounded)),
                          );
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: isFilterApplied,
                    builder: (context, value, child) {
                      return isFilterApplied.value
                          ? Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryBlue),
                                  borderRadius: BorderRadius.circular(12)),
                              child: GestureDetector(
                                onTap: () {
                                  isFilterApplied.value = false;
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: AppColors.primaryBlue,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Remove',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          color: AppColors.primaryBlue),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                valueListenable: isVisible,
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColors.dividerColor,
                        borderRadius: BorderRadius.circular(14)),
                    child: isVisible.value == true
                        ? BlocBuilder<CreateUpdateSurveyorBloc, CreateUpdateSurveyorState>(
                          builder: (context, state) {
                            if(state is AllTeamsFetchedState) {
                              teamId = state.teams[0].id;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Teams',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: const Icon(
                                        Icons.person_2_rounded,
                                        color: AppColors.textBlack,
                                      ),
                                      border: outlineBorder,
                                      disabledBorder: outlineBorder,
                                      errorBorder: outlineBorder,
                                      focusedBorder: outlineBorder,
                                      focusedErrorBorder: outlineBorder,
                                      enabledBorder: outlineBorder,
                                    ),
                                    value: teamId,
                                    items: state.teams
                                        .map<DropdownMenuItem<String>>(
                                            (item) {
                                          return DropdownMenuItem<String>(
                                              child: Text(
                                                item.teamName ?? 'Unable to fetch team name',
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: AppColors.textBlack),
                                              ),
                                              value: item.id);
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        teamId = value;
                                        print(value);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'State',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: const Icon(
                                        Icons.location_city_rounded,
                                        color: AppColors.textBlack,
                                      ),
                                      border: outlineBorder,
                                      disabledBorder: outlineBorder,
                                      errorBorder: outlineBorder,
                                      focusedBorder: outlineBorder,
                                      focusedErrorBorder: outlineBorder,
                                      enabledBorder: outlineBorder,
                                    ),
                                    value: _dropDownStateValue,
                                    items: ArrayResources.states
                                        .map<DropdownMenuItem<String>>(
                                            (String item) {
                                          return DropdownMenuItem<String>(
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: AppColors.textBlack),
                                              ),
                                              value: item);
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownStateValue = value ?? '';
                                        print(value);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Days',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  DateChips(
                                    dateSelector: dateSelector,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      isVisible.value = false;
                                      isFilterApplied.value = true;
                                      context.read<FilledSurveyBloc>()
                                        ..isFetchingFilter = true
                                        ..add(FilterSurveys(
                                            gender: 'Male',
                                            teamId: teamId ?? '',
                                            fromDate: getTimeStampFromDate(dateSelector.value),
                                            toDate: DateTime.now().toIso8601String(),
                                            isFirstFetch: true
                                        )
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: double.maxFinite,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryBlue,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            } else if(state is CreateUpdateSurveyorError) {
                              return Text(
                                'Unable to fetech'
                              );
                            }
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Lottie.asset(
                                  'assets/loading.json',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            );
                          },
                        )
                        : SizedBox.shrink(),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                valueListenable: isFilterApplied,
                builder: (context, value, child) {
                  return isFilterApplied.value
                      ? BlocConsumer<FilledSurveyBloc, FilledSurveyState>(
                          listener: (context, state) {
                            if (state is FilledSurveyError) {
                              BlocProvider.of<FilledSurveyBloc>(context)
                                  .isFetchingFilter = false;
                            } else if (state is FilterSurveysFetched) {
                              _listFilter.addAll(state.filterList);
                              BlocProvider.of<FilledSurveyBloc>(context)
                                  .isFetchingFilter = false;
                            }
                          },
                          builder: (context, state) {
                            if (state is FilterSurveysLoading &&
                                _listFilter.isEmpty) {
                              return Expanded(
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/loading.json',
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              );
                            } else if (state is FilledSurveyError &&
                                _listFilter.isEmpty) {
                              return Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.dividerColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.error_outline_outlined,
                                          color: AppColors.primaryBlue,
                                          size: 50),
                                      Text(
                                        state.message,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textBlack),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<FilledSurveyBloc>()
                                                ..isFetchingFilter = true
                                                ..add(FilterSurveys(
                                                    gender: "Male",
                                                    teamId: teamId ?? '',
                                                    fromDate: getTimeStampFromDate(dateSelector.value),
                                                    toDate: DateTime.now().toIso8601String(),
                                                    isFirstFetch: true));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        AppColors.primaryBlue,
                                                        AppColors
                                                            .primaryBlueLight,
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Text(
                                                'Try Again',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    color: AppColors.primary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: _listFilter.isEmpty
                                  ? const Center(
                                      child: Text('No Surveys Found'),
                                    )
                                  : ListView.builder(
                                      controller: scrollControllerFilter,
                                      itemBuilder: (context, index) {
                                        if (index >= _listFilter.length) {
                                          Timer(
                                              const Duration(milliseconds: 30),
                                              () {
                                            scrollControllerFilter.jumpTo(
                                                scrollControllerFilter
                                                    .position.maxScrollExtent);
                                          });
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return FilledSurveyHolder(
                                              surveyResponseModel:
                                                  _listFilter[index]);
                                        }
                                      },
                                      itemCount: _listFilter.length +
                                          (BlocProvider.of<FilledSurveyBloc>(
                                                      context)
                                                  .isFetchingFilter
                                              ? 1
                                              : 0),
                                    ),
                            );
                          },
                        )
                      : BlocConsumer<FilledSurveyBloc, FilledSurveyState>(
                          listener: (context, state) {
                          if (state is FilledSurveyError) {
                            BlocProvider.of<FilledSurveyBloc>(context)
                                .isFetchingAll = false;
                          } else if (state is FilledSurveyFetched) {
                            _listAll.addAll(state.list);
                            BlocProvider.of<FilledSurveyBloc>(context)
                                .isFetchingAll = false;
                          }
                        }, builder: (context, state) {
                          if (state is FilledSurveyLoading &&
                              _listAll.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Lottie.asset(
                                  'assets/loading.json',
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            );
                          } else if (state is FilledSurveyError &&
                              _listAll.isEmpty) {
                            return Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.dividerColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.error_outline_outlined,
                                        color: AppColors.primaryBlue, size: 50),
                                    Text(
                                      state.message,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlack),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.read<FilledSurveyBloc>()
                                              ..isFetchingAll = true
                                              ..add(const FetchAllSurveys(
                                                  isFirstFetch: true));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      AppColors.primaryBlue,
                                                      AppColors
                                                          .primaryBlueLight,
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Text(
                                              'Try Again',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: _listAll.isEmpty
                                ? const Center(
                                    child: Text('No Surveys Found'),
                                  )
                                : ListView.builder(
                                    controller: scrollControllerAll,
                                    itemBuilder: (context, index) {
                                      if (index >= _listAll.length) {
                                        Timer(const Duration(milliseconds: 30),
                                            () {
                                          scrollControllerAll.jumpTo(
                                              scrollControllerAll
                                                  .position.maxScrollExtent);
                                        });
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return FilledSurveyHolder(
                                            surveyResponseModel:
                                                _listAll[index]);
                                      }
                                    },
                                    itemCount: _listAll.length +
                                        (BlocProvider.of<FilledSurveyBloc>(
                                                    context)
                                                .isFetchingAll
                                            ? 1
                                            : 0),
                                  ),
                          );
                        });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTimeStampFromDate(int index) {
    final currentDate = DateTime.now();
    switch(index) {
      case 0: {
        return '';
      }
      case 1: {
        final date = currentDate.subtract(const Duration(days: 30));
        return date.toIso8601String();
      }
      case 2: {
        final date = currentDate.subtract(const Duration(days: 14));
        return date.toIso8601String();
      }
      case 3: {
        final date = currentDate.subtract(const Duration(days: 7));
        return date.toIso8601String();
      }
      case 4: {
        final date = currentDate.subtract(const Duration(days: 5));
        return date.toIso8601String();
      }
    }
    return '';
  }
}
