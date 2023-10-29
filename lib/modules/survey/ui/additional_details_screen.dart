import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_result_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  String _dropDownReligionValue = ArrayResources.religions[0];
  String _dropDownCasteValue = ArrayResources.castes[0];

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.lightBlack
        ),
        borderRadius: BorderRadius.circular(16)
    );

    return BlocListener<SurveyBloc, SurveyState>(
      listener: (context, state) {
        if (state is SurveySuccessState) {
          context.go(RouteNames.surveyResultScreen);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit the survey'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () =>
                      context.go(RouteNames.surveyorHomeScreen),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
        },
        child: SafeArea(
          child: Scaffold(
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
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text('Do you want to exit the survey'),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        context.go(RouteNames.surveyorHomeScreen),
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: Text(
                            'Additional details',
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: phoneController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Name',
                                    prefixIcon: const Icon(Icons.phone, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (phone) {
                                    if (phone != null &&
                                        phone.isNotEmpty &&
                                        phone.length != 10) {
                                      return 'Please enter correct phone number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Religion',
                                    prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  value: _dropDownReligionValue,
                                  items: ArrayResources.religions
                                      .map<DropdownMenuItem<String>>((String item) {
                                    return DropdownMenuItem<String>(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.textBlack
                                        ),
                                      ),
                                      value: item
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownReligionValue = value ?? '';
                                      print(value);
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Caste',
                                    prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  value: _dropDownCasteValue,
                                  items: ArrayResources.castes
                                      .map<DropdownMenuItem<String>>((String item) {
                                    return DropdownMenuItem<String>(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.textBlack
                                        ),
                                      ),
                                      value: item
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownCasteValue = value ?? '';
                                      print(value);
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  controller: addressController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  cursorColor: AppColors.lightBlack,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Address',
                                    prefixIcon: const Icon(Icons.maps_home_work_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    context.read<SurveyBloc>().add(SkipAndFinishSurveyEvent());
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryBlue
                                      ),
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: AppColors.primaryBlue
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomButton(
                                  onTap: (){
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    context.read<SurveyBloc>().add(SubmitAdditionalDetailsAndFinishEvent(
                                      mobileNum: phoneController.text.trim(),
                                      address: addressController.text.trim(),
                                      religion: _dropDownReligionValue.trim(),
                                      caste: _dropDownCasteValue.trim()
                                    ));
                                  },
                                  text: 'Submit',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
