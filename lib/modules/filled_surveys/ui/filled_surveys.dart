import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/widgets/date_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/widgets/gender_chips.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/surveyor_home_reponse_model.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/utils/recent_survey_holder.dart';

class AdminFilledSurveys extends StatefulWidget {
  const AdminFilledSurveys({super.key});

  @override
  State<AdminFilledSurveys> createState() => _AdminFilledSurveysState();
}

class _AdminFilledSurveysState extends State<AdminFilledSurveys> {
  String _dropDownStateValue = ArrayResources.states[0];
  String _dropDownUserValue = ArrayResources.users[0];
  ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);

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
                  IconButton(
                      onPressed: () {
                        if (isVisible.value == true) {
                          isVisible.value = false;
                        } else {
                          isVisible.value = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(isVisible.value == true
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded))
                ],
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
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'User',
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
                                value: _dropDownUserValue,
                                items: ArrayResources.users
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
                                    _dropDownUserValue = value ?? '';
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
                              DateChips(),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isVisible.value = false;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 40,
                                  width: double.maxFinite,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      borderRadius: BorderRadius.circular(12)),
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
                          )
                        : SizedBox.shrink(),
                  );
                },
              ),
              SizedBox(height: 10,),
              BlocBuilder<FilledSurveyBloc, FilledSurveyState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => RecentSurveyHolder(
                          surveyorHomeResponseModel:
                              SurveyorHomeResponseModel()),
                      itemCount: 20,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
