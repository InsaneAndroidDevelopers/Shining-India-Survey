import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/global/widgets/loader.dart';

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

    return BlocConsumer<SurveyBloc, SurveyState>(
      listener: (context, state) {
        if (state is SurveySuccessState) {
          context.go(RouteNames.surveyResultScreen);
        } if(state is SurveyErrorState) {
          CustomFlushBar(
            context: context,
            message: state.message,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.cancel_outlined, color: Colors.white)
          ).show();
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to exit the survey'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.go(RouteNames.surveyorHomeScreen),
                    child: const Text('Yes'),
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
                                  title: const Text('Are you sure?'),
                                  content: const Text('Do you want to exit the survey'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => context.pop(false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          context.go(RouteNames.surveyorHomeScreen),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 16,),
                          const Expanded(
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
                                      labelText: 'Phone Number',
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
                                  const SizedBox(
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
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: AppColors.textBlack
                                            ),
                                          )
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownReligionValue = value ?? '';
                                      });
                                    },
                                  ),
                                  const SizedBox(
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
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: AppColors.textBlack
                                            ),
                                          )
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownCasteValue = value ?? '';
                                      });
                                    },
                                  ),
                                  const SizedBox(
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
                            const SizedBox(
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
                                      padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primaryBlue
                                          ),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: state is SurveyLoadingState
                                      ? const Loader()
                                      : const Text(
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
                                const SizedBox(
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
                                    child: state is SurveyLoadingState
                                    ? const Loader()
                                    : const Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
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
        );
      },
    );
  }
}
