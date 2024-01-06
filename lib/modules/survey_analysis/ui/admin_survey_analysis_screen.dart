import 'dart:typed_data';
import 'package:flutter/material.dart';
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
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/age_chips.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/analysis_detail.dart';
import 'package:shining_india_survey/modules/survey_analysis/utils/convert_pdf.dart';
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
  State<AdminSurveyAnalysisScreen> createState() =>
      _AdminSurveyAnalysisScreenState();
}

class _AdminSurveyAnalysisScreenState extends State<AdminSurveyAnalysisScreen> {

  ValueNotifier<bool> isVisible = ValueNotifier<bool>(false);
  ValueNotifier<int> genderIndex = ValueNotifier<int>(0);
  ValueNotifier<int> ageIndex = ValueNotifier<int>(0);
  String? teamId;
  ValueNotifier<int> dateIndex = ValueNotifier(0);

  final PdfService service = PdfService();
  final screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnalysisBloc>(context).add(GetAllAnalysis());
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());
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
                    SizedBox(width: 16,),
                    Expanded(
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
                  Text(
                    'Filters',
                    style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isVisible,
                    builder: (context, value, child) {
                      return IconButton(
                          onPressed: () {
                            if (isVisible.value == true) {
                              isVisible.value = false;
                            } else {
                              isVisible.value = true;
                            }
                          },
                          icon: Icon(isVisible.value == true ? Icons
                              .keyboard_arrow_down_rounded : Icons
                              .keyboard_arrow_up_rounded)
                      );
                    },
                  ),
                ],
              ),
              ValueListenableBuilder(
                key: Key('container'),
                valueListenable: isVisible,
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColors.dividerColor,
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: isVisible.value == true
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Text(
                          'Gender',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        GenderChips(selectedIndex: genderIndex),
                        SizedBox(height: 8,),
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
                        SizedBox(height: 8,),
                        Text(
                          'Age',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        AgeChips(ageIndex: ageIndex),
                        SizedBox(height: 8,),
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
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AnalysisBloc>(context).add(
                              GetFilteredAnalysis(
                                maxAge: getMinMaxAgeFromIndex(ageIndex.value).maxAge,
                                minAge: getMinMaxAgeFromIndex(ageIndex.value).minAge,
                                toDate: DateTime.now().toIso8601String(),
                                fromDate: getTimeStampFromDate(dateIndex.value),
                                gender: getGenderFromIndex(genderIndex.value),
                                teamId: teamId ?? ''
                              )
                            );
                            isVisible.value = false;
                          },
                          child: Container(
                            height: 40,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(
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
                        SizedBox(height: 10,),
                      ],
                    ) : SizedBox.shrink(),
                  );
                },
              ),
              SizedBox(height: 10,),
              Expanded(
                child: BlocBuilder<AnalysisBloc, AnalysisState>(
                  builder: (context, state) {
                    if (state is AnalysisLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/loading.json',
                          width: 150,
                          height: 150,
                        ),
                      );
                    } else if (state is AnalysisError) {
                      CustomFlushBar(
                        context: context,
                        message: state.message,
                        icon: Icon(Icons.cancel_outlined, color: AppColors.primary,),
                        backgroundColor: Colors.red
                      ).show();
                    } else if (state is AnalysisSuccess) {
                      if (state.analysisList.isEmpty) {
                        return Center(
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
                        return ListView.builder(
                          itemCount: state.analysisList.length,
                          itemBuilder: (context, index) {
                            return AnalysisDetail(
                              question: state.analysisList[index].sId ?? '-',
                              chartData: state.analysisList[index].answers ?? [],
                            );
                          },
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
                    convertPdf(state.analysisList, screenshotController, service);
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
