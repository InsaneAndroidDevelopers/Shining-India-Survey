import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shining_india_survey/global/methods/get_gender.dart';
import 'package:shining_india_survey/global/methods/get_min_max_age.dart';
import 'package:shining_india_survey/global/methods/get_timestamp_from_date.dart';
import 'package:shining_india_survey/global/widgets/drop_down_text_form_field.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/date_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/gender_chips.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/bloc/analysis_bloc.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/age_chips.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/analysis_detail.dart';
import 'package:shining_india_survey/services/pdf_service.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/global/widgets/loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminSurveyAnalysisScreen extends StatefulWidget {
  const AdminSurveyAnalysisScreen({super.key});

  @override
  State<AdminSurveyAnalysisScreen> createState() => _AdminSurveyAnalysisScreenState();
}

class _AdminSurveyAnalysisScreenState extends State<AdminSurveyAnalysisScreen> with WidgetsBindingObserver{

  ValueNotifier<bool> isFilterApplied = ValueNotifier<bool>(false);
  ValueNotifier<int> genderIndex = ValueNotifier<int>(0);
  ValueNotifier<int> ageIndex = ValueNotifier<int>(0);
  String? teamId;
  String? _dropDownStateValue;
  ValueNotifier<int> dateIndex = ValueNotifier(0);
  List<GlobalKey>? _keys;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AnalysisBloc>(context).add(GetAllAnalysis());
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());
  }

  @override
  void dispose() {
    super.dispose();
    genderIndex.dispose();
    ageIndex.dispose();
    dateIndex.dispose();
    isFilterApplied.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
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
                    const SizedBox(width: 16,),
                    const Expanded(
                      child: Text(
                        'Analysis',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
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
                        fontFamily: 'Poppins'
                    ),
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
                                              BlocProvider.of<AnalysisBloc>(context).add(GetAllAnalysis());
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
                                            _dropDownStateValue = value ?? '';
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
                                            BlocProvider.of<AnalysisBloc>(context).add(
                                                GetFilteredAnalysis(
                                                    maxAge: getMinMaxAgeFromIndex(ageIndex.value).maxAge,
                                                    minAge: getMinMaxAgeFromIndex(ageIndex.value).minAge,
                                                    toDate: DateTime.now().toIso8601String(),
                                                    fromDate: getTimeStampFromDate(dateIndex.value),
                                                    gender: getGenderFromIndex(genderIndex.value),
                                                    teamId: teamId ?? '',
                                                    state: _dropDownStateValue ?? ''
                                                )
                                            );
                                            isFilterApplied.value = true;
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
              const SizedBox(height: 10,),
              Expanded(
                child: BlocConsumer<AnalysisBloc, AnalysisState>(
                  listener: (context, state) {
                    if (state is AnalysisError) {
                      CustomFlushBar(
                          context: context,
                          message: state.message,
                          icon: const Icon(Icons.cancel_outlined, color: AppColors.primary,),
                          backgroundColor: Colors.red
                      ).show();
                    }
                  },
                  builder: (context, state) {
                    if (state is AnalysisLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/loading.json',
                          width: 150,
                          height: 150,
                        ),
                      );
                    } else if (state is AnalysisSuccess) {
                      if (state.analysisList.isEmpty) {
                        return const Center(
                          child: Text(
                            'No questions',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                            )
                          )
                        );
                      } else {
                        return SingleChildScrollView(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.analysisList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return AnalysisDetail(
                                analysisResponseModel: state.analysisList[index],
                              );
                            },
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<AnalysisBloc, AnalysisState>(
          builder: (context, state) {
            if (state is AnalysisSuccess) {
              if (state.analysisList.isNotEmpty) {
                return FloatingActionButton(
                  onPressed: () async {
                    final file = await PdfService().createPdf(state.analysisList);
                    await PdfService().savePdfFile('Filename', file);
                  },
                  child: Icon(Icons.save_alt),
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
