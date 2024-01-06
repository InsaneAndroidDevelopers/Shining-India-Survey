import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_team_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';

import '../../../global/values/app_colors.dart';
import '../../../global/widgets/back_button.dart';

class AdminTeamsScreen extends StatefulWidget {
  const AdminTeamsScreen({super.key});

  @override
  State<AdminTeamsScreen> createState() => _AdminTeamsScreenState();
}

class _AdminTeamsScreenState extends State<AdminTeamsScreen> {
  final teamController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CreateUpdateSurveyorBloc>().add(GetAllTeamsData());
  }

  @override
  void dispose() {
    super.dispose();
    teamController.dispose();
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
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'Your teams',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await openDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dividerColor),
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle),
                        child: Icon(Icons.add, color: AppColors.black),
                      ),
                    )
                  ],
                ),
              ),
              BlocListener<CreateUpdateSurveyorBloc, CreateUpdateSurveyorState>(
                listener: (context, state) {
                  if (state is TeamCreatedSuccessState) {
                    CustomFlushBar(
                      message: 'Team created successfully',
                      backgroundColor: AppColors.green,
                      icon: Icon(
                        Icons.done_rounded,
                        color: AppColors.primary,
                      ),
                      context: context
                    ).show();
                  }
                },
                child: BlocBuilder<CreateUpdateSurveyorBloc,
                    CreateUpdateSurveyorState>(
                  builder: (context, state) {
                    if (state is CreateUpdateSurveyorLoading) {
                      return Expanded(
                        child: Center(
                          child: Lottie.asset(
                            'assets/loading.json',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      );
                    } else if (state is CreateUpdateSurveyorError) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
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
                                  Icon(
                                    Icons.error_outline_outlined,
                                    color: AppColors.primaryBlue,
                                    size: 60,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.message,
                                    textAlign: TextAlign.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CreateUpdateSurveyorBloc>()
                                              .add(GetAllTeamsData());
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    AppColors.primaryBlue,
                                                    AppColors.primaryBlueLight,
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            'Try Again',
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
                          ],
                        ),
                      );
                    } else if (state is AllTeamsFetchedState) {
                      if (state.teams.isEmpty) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
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
                                    Text(
                                      "No team present\nClick on + button to add",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlack),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryBlue),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: AppColors.primaryBlue,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins',
                                                      color: AppColors
                                                          .primaryBlue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return AdminTeamWidget(
                                    teamModel: state.teams[index]
                                );
                              },
                              itemCount: state.teams.length),
                        );
                      }
                    }
                    return SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Team'),
          content: TextField(
            controller: teamController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter team name',
                prefixIcon: Icon(Icons.people_alt_rounded)),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  context.pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if(teamController.text.isEmpty) {
                    CustomFlushBar(
                        message: 'Please enter team name',
                        backgroundColor: Colors.red,
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primary,
                        ),
                        context: context
                    ).show();
                    return;
                  }
                  context.pop();
                  context.read<CreateUpdateSurveyorBloc>().add(CreateTeam(teamName: teamController.text));
                },
                child: Text('Create')),
          ],
        );
      },
    );
  }
}
