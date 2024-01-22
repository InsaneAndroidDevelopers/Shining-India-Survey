import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shining_india_survey/global/methods/get_gender.dart';
import 'package:shining_india_survey/global/methods/get_min_max_age.dart';
import 'package:shining_india_survey/global/methods/get_timestamp_from_date.dart';
import 'package:shining_india_survey/global/widgets/drop_down_text_form_field.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/date_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/filled_survey_holder.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/gender_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/survey_list_widget.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/age_chips.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/recent_survey_model.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/widgets/recent_survey_holder.dart';

class AdminFilledSurveys extends StatefulWidget {
  const AdminFilledSurveys({super.key});

  @override
  State<AdminFilledSurveys> createState() => _AdminFilledSurveysState();
}

class _AdminFilledSurveysState extends State<AdminFilledSurveys> {

  final List<SurveyResponseModel> _listAll = [];
  final List<SurveyResponseModel> _listFilter = [];

  ValueNotifier<bool> isFilterApplied = ValueNotifier(false);
  ValueNotifier<int> genderIndex = ValueNotifier<int>(0);
  ValueNotifier<int> ageIndex = ValueNotifier<int>(0);
  String? teamId;
  String? _dropDownStateValue;
  ValueNotifier<int> dateIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context.read<FilledSurveyBloc>().add(const FetchAllSurveys(isFirstFetch: true));
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());
  }

  @override
  void dispose() {
    super.dispose();
    isFilterApplied.dispose();
    genderIndex.dispose();
    ageIndex.dispose();
    dateIndex.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
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
                            const SizedBox(
                              width: 16,
                            ),
                            const Expanded(
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
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isFilterApplied,
                    builder: (context, value, child) {
                      return IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              showDragHandle: true,
                              isScrollControlled: true,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                              onPressed: (){
                                                isFilterApplied.value = false;
                                                context.pop();
                                              },
                                              child: const Text(
                                                'Clear All',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: AppColors.primaryBlue,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              )
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        const Text(
                                          'Gender',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        GenderChips(selectedIndex: genderIndex),
                                        const SizedBox(height: 8,),
                                        const Text(
                                          'Teams',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        BlocBuilder<CreateUpdateSurveyorBloc, CreateUpdateSurveyorState>(
                                          builder: (context, state) {
                                            if(state is AllTeamsFetchedState) {
                                              return DropDownTextField(
                                                prefixIcon: const Icon(
                                                  Icons.person_2_rounded,
                                                  color: AppColors.textBlack,
                                                ),
                                                value: teamId,
                                                items: state.teams.map<DropdownMenuItem<String>>((item) {
                                                  return DropdownMenuItem<String>(
                                                      value: item.id,
                                                      child: Text(
                                                        item.teamName ??
                                                            'Unable to fetch team name',
                                                        style: const TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontSize: 14,
                                                            color: AppColors.textBlack),
                                                      ));
                                                }).toList(),
                                                onChanged: (val) {
                                                  teamId = val;
                                                },
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                        const SizedBox(height: 8,),
                                        DropDownTextField(
                                          prefixIcon: const Icon(Icons.location_city_rounded, color: AppColors.textBlack,),
                                          value: _dropDownStateValue,
                                          items: ArrayResources.states
                                              .map<DropdownMenuItem<String>>((String item) {
                                            return DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: AppColors.textBlack
                                                  ),
                                                ));
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _dropDownStateValue = value ?? '';
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 8,),
                                        const Text(
                                          'Age',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        AgeChips(ageIndex: ageIndex),
                                        const SizedBox(height: 8,),
                                        const Text(
                                          'Days',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        DateChips(dateSelector: dateIndex),
                                        const SizedBox(height: 8,),
                                        GestureDetector(
                                          onTap: () {
                                            isFilterApplied.value = true;
                                            context.read<FilledSurveyBloc>()
                                              ..isFetchingFilter = true
                                              ..add(FilterSurveys(
                                                  gender: getGenderFromIndex(genderIndex.value),
                                                  teamId: teamId ?? '',
                                                  fromDate: getTimeStampFromDate(dateIndex.value),
                                                  toDate: DateTime.now().toIso8601String(),
                                                  isFirstFetch: true,
                                                  minAge: getMinMaxAgeFromIndex(ageIndex.value).minAge,
                                                  maxAge: getMinMaxAgeFromIndex(ageIndex.value).maxAge,
                                                  state: _dropDownStateValue ?? ''
                                                )
                                              );
                                            debugPrint(getGenderFromIndex(genderIndex.value));
                                            context.pop();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: double.maxFinite,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryBlue,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Text(
                                              'Apply',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Badge(
                            backgroundColor: isFilterApplied.value == true
                                ? Colors.red
                                : Colors.transparent,
                            child: const Icon(Icons.filter_alt),
                          )
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
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
                              if(state.isFirstFetch) {
                                _listFilter.clear();
                              }
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
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.dividerColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.error_outline_outlined,
                                          color: AppColors.primaryBlue,
                                          size: 50),
                                      Text(
                                        state.message,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textBlack),
                                      ),
                                      const SizedBox(
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
                                                    gender: getGenderFromIndex(genderIndex.value),
                                                    teamId: teamId ?? '',
                                                    fromDate: getTimeStampFromDate(dateIndex.value),
                                                    toDate: DateTime.now().toIso8601String(),
                                                    isFirstFetch: true,
                                                    minAge: getMinMaxAgeFromIndex(ageIndex.value).minAge,
                                                    maxAge: getMinMaxAgeFromIndex(ageIndex.value).maxAge,
                                                    state: _dropDownStateValue ?? ''
                                                  )
                                                );
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
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
                                              child: const Text(
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
                                  : SurveyListWidget(
                                    isFilter: true,
                                  list: _listFilter,
                                  genderIndex: genderIndex,
                                  ageIndex: ageIndex,
                                  dateIndex: dateIndex,
                                  teamId: teamId,
                                state: _dropDownStateValue,
                              )
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
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.dividerColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.error_outline_outlined,
                                        color: AppColors.primaryBlue, size: 50),
                                    Text(
                                      state.message,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlack),
                                    ),
                                    const SizedBox(
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
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
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
                                            child: const Text(
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
                                : SurveyListWidget(
                                isFilter: false,
                                list: _listAll,
                                genderIndex: genderIndex,
                                ageIndex: ageIndex,
                                dateIndex: dateIndex,
                              teamId: teamId,
                              state: _dropDownStateValue,
                            )
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
}
