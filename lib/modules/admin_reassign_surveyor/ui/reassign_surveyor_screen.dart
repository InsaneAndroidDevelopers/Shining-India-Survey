import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/routes/routes.dart';

class ReassignSurveyorScreen extends StatefulWidget {
  final String name;
  final String email;
  final String surveyorId;
  const ReassignSurveyorScreen({super.key, required this.surveyorId, required this.name, required this.email});

  @override
  State<ReassignSurveyorScreen> createState() => _ReassignSurveyorScreenState();
}

class _ReassignSurveyorScreenState extends State<ReassignSurveyorScreen> {

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  ValueNotifier<List<TeamModel>> _teamsNotifier = ValueNotifier([]);
  String? team;

  @override
  void initState() {
    super.initState();
    userNameController.text = widget.name;
    emailController.text = widget.email;
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
          listener: (context, state) {
            if(state is SurveyorAddedState) {
              context.go(RouteNames.adminHomeScreen);
            } else if(state is CreateUpdateSurveyorError) {
              CustomFlushBar(
                  message: state.message,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.cancel_outlined, color: AppColors.primary,),
                  context: context
              ).show();
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
                            widget.name,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: false,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            enabled: false,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _teamsNotifier,
                            builder: (context, value, child) {
                              return _teamsNotifier.value.isNotEmpty
                                  ? DropdownButtonFormField(
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
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            onTap: () {
                              if(team != null && team != '') {
                                context.read<CreateUpdateSurveyorBloc>().add(
                                    AddSurveyorIntoTeam(
                                        teamId: team ?? '',
                                        surveyorId: widget.surveyorId
                                    )
                                );
                              }
                            },
                            child: const Text(
                              'Assign to team',
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
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
