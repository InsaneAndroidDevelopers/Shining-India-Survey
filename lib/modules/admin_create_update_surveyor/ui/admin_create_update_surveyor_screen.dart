import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/global/widgets/loader.dart';

class AdminCreateUpdateSurveyorScreen extends StatefulWidget {
  final bool isUpdate;
  final String name;
  final bool isActive;
  final String surveyorId;
  final String teamId;
  final String teamName;
  final String email;

  const AdminCreateUpdateSurveyorScreen(
      {super.key, required this.isUpdate, required this.name, required this.surveyorId, required this.teamName, required this.email, required this.isActive, required this.teamId});

  @override
  State<AdminCreateUpdateSurveyorScreen> createState() =>
      _AdminCreateUpdateSurveyorScreenState();
}

class _AdminCreateUpdateSurveyorScreenState
    extends State<AdminCreateUpdateSurveyorScreen> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final teamController = TextEditingController();

  bool isPasswordVisible = false;
  String? team;

  ValueNotifier<List<TeamModel>> _teamsNotifier = ValueNotifier([]);
  ValueNotifier<bool> activeNotifier = ValueNotifier(true);
  ValueNotifier<bool> isPasswordFieldVisible = ValueNotifier(false);

  String? _validateEmail(String? email) {
    if (email != null) {
      if (email.isNotEmpty && !EmailValidator.validate(email)) {
        return 'Please enter correct email address';
      } else if (email.isEmpty) {
        return 'Please enter email address';
      }
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password != null) {
      if (password.isNotEmpty && password.length < 8) {
        return 'Password must be at least 8 characters';
      } else if (password.isEmpty) {
        return 'Please enter password';
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    team = widget.teamId;
    teamController.text = widget.teamName;
    userNameController.text = widget.name;
    emailController.text = widget.email;
    activeNotifier.value = widget.isActive;
    !widget.isUpdate
      ? isPasswordFieldVisible.value = true
      : isPasswordFieldVisible.value = false;
    !widget.isUpdate
        ? context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData())
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightBlack),
        borderRadius: BorderRadius.circular(16));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<CreateUpdateSurveyorBloc, CreateUpdateSurveyorState>(
          listener: (context, state) {
            if(state is SurveyorAddedState) {
              context.go(RouteNames.adminHomeScreen);
            } if(state is SurveyorUpdatedState) {
              context.go(RouteNames.adminHomeScreen);
            } else if(state is CreateUpdateSurveyorError) {
              CustomFlushBar(
                message: state.message,
                backgroundColor: Colors.red,
                icon: Icon(Icons.cancel_outlined, color: AppColors.primary,),
                context: context
              ).show();
            } else if(state is SurveyorDeletedState) {
              context.go(RouteNames.adminHomeScreen);
            } else if(state is AllTeamsFetchedState) {
              _teamsNotifier.value = state.teams;
              if(!widget.isUpdate) {
                team = _teamsNotifier.value[0].id;
              }
            }
          },
          builder: (context, state) {
            if(state is CreateUpdateSurveyorLoading) {
              return Loader();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
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
                            widget.isUpdate ? widget.name : 'Create Surveyor',
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
                  widget.isUpdate ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryBlue
                          ),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: GestureDetector(
                        onTap: (){
                          context.read<CreateUpdateSurveyorBloc>().add(RemoveSurveyor(teamId: widget.teamId, surveyorId: widget.surveyorId));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cancel, color: AppColors.primaryBlue,),
                            SizedBox(width: 2,),
                            Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: AppColors.primaryBlue
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) : SizedBox.shrink(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: userNameController,
                              builder: (context, value, child) {
                                return TextFormField(
                                  enabled: !widget.isUpdate,
                                  controller: userNameController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack),
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Name',
                                    prefixIcon: const Icon(
                                      Icons.person_2_rounded,
                                      color: AppColors.textBlack,
                                    ),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return 'Please enter user name';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: emailController,
                              builder: (context, value, child) {
                                return TextFormField(
                                  enabled: !widget.isUpdate,
                                    controller: emailController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AppColors.textBlack),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: AppColors.lightBlack,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'E-mail',
                                      prefixIcon: const Icon(
                                        Icons.email_rounded,
                                        color: AppColors.textBlack,
                                      ),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.lightBlack),
                                      border: outlineBorder,
                                      disabledBorder: outlineBorder,
                                      errorBorder: outlineBorder,
                                      focusedBorder: outlineBorder,
                                      focusedErrorBorder: outlineBorder,
                                      enabledBorder: outlineBorder,
                                    ),
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: _validateEmail);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.isUpdate==true
                              ? TextFormField(
                                enabled: !widget.isUpdate,
                                controller: teamController,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.textBlack),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColors.lightBlack,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Team',
                                  prefixIcon: const Icon(
                                    Icons.groups_2_rounded,
                                    color: AppColors.textBlack,
                                  ),
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: AppColors.lightBlack),
                                  border: outlineBorder,
                                  disabledBorder: outlineBorder,
                                  errorBorder: outlineBorder,
                                  focusedBorder: outlineBorder,
                                  focusedErrorBorder: outlineBorder,
                                  enabledBorder: outlineBorder,
                                ),
                            )
                            :_teamsNotifier.value.isNotEmpty
                             ? ValueListenableBuilder(
                              valueListenable: _teamsNotifier,
                              builder: (context, value, child) {
                                return DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Team',
                                    prefixIcon: const Icon(
                                      Icons.groups_2_rounded,
                                      color: AppColors.textBlack,
                                    ),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  value: team,
                                  items: _teamsNotifier.value
                                      .map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                        child: Text(
                                          e.teamName ?? 'Unable to fetch team name',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: AppColors.textBlack),
                                        ),
                                        value: e.id);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      team = value;
                                      print(value);
                                    });
                                  },
                                );
                              },
                            )
                             : DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabled: false,
                                filled: true,
                                labelText: 'Team',
                                prefixIcon: const Icon(
                                  Icons.groups_2_rounded,
                                  color: AppColors.textBlack,
                                ),
                                labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: AppColors.lightBlack),
                                border: outlineBorder,
                                disabledBorder: outlineBorder,
                                errorBorder: outlineBorder,
                                focusedBorder: outlineBorder,
                                focusedErrorBorder: outlineBorder,
                                enabledBorder: outlineBorder,
                              ),
                              value: 'Unable to fetch teams',
                              items: [DropdownMenuItem<String>(
                                    child: Text(
                                     'Unable to fetch teams',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.textBlack),
                                    ),
                                    value: 'Unable to fetch teams')],
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: isPasswordFieldVisible,
                              builder: (context, value, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                          controller: passwordController,
                                          enabled: isPasswordFieldVisible.value,
                                          keyboardType: TextInputType.text,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: AppColors.textBlack),
                                          cursorColor: AppColors.lightBlack,
                                          obscureText: !isPasswordVisible,
                                          decoration: InputDecoration(
                                            fillColor: isPasswordFieldVisible.value ? Colors.white : AppColors.dividerColor,
                                            filled: true,
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: AppColors.lightBlack),
                                            prefixIcon: const Icon(
                                              Icons.key_rounded,
                                              color: AppColors.textBlack,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                isPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: AppColors.textBlack,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isPasswordVisible =
                                                  !isPasswordVisible;
                                                });
                                              },
                                            ),
                                            border: outlineBorder,
                                            disabledBorder: outlineBorder,
                                            errorBorder: outlineBorder,
                                            focusedBorder: outlineBorder,
                                            focusedErrorBorder: outlineBorder,
                                            enabledBorder: outlineBorder,
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: isPasswordFieldVisible.value
                                            ? _validatePassword
                                            : null),
                                    ),
                                    widget.isUpdate==true ? IconButton(
                                      onPressed: (){
                                        isPasswordFieldVisible.value = !isPasswordFieldVisible.value;
                                      },
                                      icon: Icon(Icons.edit)
                                    ) : SizedBox.shrink()
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.isUpdate==true
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: activeNotifier,
                                  builder: (context, value, child) {
                                    return Switch(
                                      activeColor: AppColors.primaryBlue,
                                      value: activeNotifier.value,
                                      onChanged: (val){
                                        activeNotifier.value = val;
                                      }
                                    );
                                  },
                                ),
                              ],
                            ) : SizedBox.shrink(),
                            SizedBox(height: 10,),
                            widget.isUpdate==false
                            ? CustomButton(
                              onTap: () {
                                if(_formKey.currentState!.validate() && (team != null && team != '')) {
                                  context.read<CreateUpdateSurveyorBloc>().add(
                                    CreateSurveyor(
                                      teamId: team ?? '',
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: userNameController.text.trim()
                                    )
                                  );
                                }
                              },
                              child: const Text(
                                'Create',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                                : CustomButton(
                              onTap: () {
                                if(_formKey.currentState!.validate() && (team != null && team != '')) {
                                  context.read<CreateUpdateSurveyorBloc>().add(
                                      UpdateSurveyor(
                                        isActive: activeNotifier.value,
                                        surveyorId: widget.surveyorId,
                                        password: isPasswordFieldVisible.value
                                          ? passwordController.text
                                          : null
                                      )
                                  );
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
