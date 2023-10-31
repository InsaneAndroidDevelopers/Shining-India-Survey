import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/utils/custom_flushbar.dart';
import 'package:shining_india_survey/utils/custom_loader.dart';

class AdminCreateUpdateSurveyorScreen extends StatefulWidget {
  final bool isUpdate;
  final String name;
  final String surveyorId;
  final String teamId;

  const AdminCreateUpdateSurveyorScreen(
      {super.key, required this.isUpdate, required this.name, required this.surveyorId, required this.teamId});

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

  bool isPasswordVisible = false;
  String? team;

  ValueNotifier<List<TeamModel>> _teamsNotifier = ValueNotifier([]);

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
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());
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
          listenWhen: (previous, current) {
            if(previous is CreateUpdateSurveyorLoading) {
              context.pop();
            }
            return true;
          },
          listener: (context, state) {
            if(state is SurveyorAddedState) {
              CustomFlushBar(
                message: 'Surveyor created successfully',
                backgroundColor: AppColors.green,
                icon: Icon(Icons.done, color: AppColors.primary,),
                context: context
              ).show();
              context.go(RouteNames.adminHomeScreen);
            } else if(state is CreateUpdateSurveyorLoading) {
              CustomLoader(
                context: context
              ).show();
            } else if(state is CreateUpdateSurveyorError) {
              CustomFlushBar(
                message: state.message,
                backgroundColor: Colors.red,
                icon: Icon(Icons.cancel_outlined, color: AppColors.primary,),
                context: context
              ).show();
            } else if(state is SurveyorDeletedState) {
              CustomFlushBar(
                  message: 'Surveyor deleted successfully',
                  backgroundColor: AppColors.green,
                  icon: Icon(Icons.delete_rounded, color: AppColors.primary,),
                  context: context
              ).show();
              context.go(RouteNames.adminHomeScreen);
            } else if(state is AllTeamsFetchedState) {
              _teamsNotifier.value = state.teams;
              team = _teamsNotifier.value[0].id;
            }
          },
          builder: (context, state) {
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
                              'Remove from team',
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
                            _teamsNotifier.value.isNotEmpty
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
                            widget.isUpdate==false
                            ? ValueListenableBuilder(
                              valueListenable: passwordController,
                              builder: (context, value, child) {
                                return TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AppColors.textBlack),
                                    cursorColor: AppColors.lightBlack,
                                    obscureText: !isPasswordVisible,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
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
                                    validator: _validatePassword);
                              },
                            ) : SizedBox.shrink(),
                            SizedBox(
                              height: 10,
                            ),
                            widget.isUpdate==false
                            ? CustomButton(
                              onTap: () {
                                if(_formKey.currentState!.validate() && (team != null && team != '')) {
                                  context.read<CreateUpdateSurveyorBloc>().add(
                                    CreateSurveyor(
                                      teamId: widget.teamId,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: userNameController.text.trim()
                                    )
                                  );
                                }
                              },
                              text: 'Create',
                            ) : SizedBox.shrink()
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
