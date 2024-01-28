import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_surveyor_widget.dart';
import 'package:shining_india_survey/modules/admin_reassign_surveyor/core/bloc/unassigned_surveyor_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';

class AdminUnassignedSurveyorsScreen extends StatefulWidget {
  const AdminUnassignedSurveyorsScreen({super.key});

  @override
  State<AdminUnassignedSurveyorsScreen> createState() => _AdminUnassignedSurveyorsScreenState();
}

class _AdminUnassignedSurveyorsScreenState extends State<AdminUnassignedSurveyorsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<UnassignedSurveyorBloc>().add(FetchAllUnassignedSurveyors());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      onTap: (){
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<UnassignedSurveyorBloc, UnassignedSurveyorState>(
                  builder: (context, state) {
                    if(state is UnassignedSurveyorLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/loading.json',
                          width: 150,
                          height: 150,
                        ),
                      );
                    } else if(state is UnassignedSurveyorError) {
                      return Column(
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
                                const Icon(
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
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if(state is UnassignedSurveyorsFetched) {
                      if(state.list.isEmpty) {
                        return const Center(
                          child: Text(
                            'No unassigned surveyors found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack),
                          )
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryBlueLight,
                                  borderRadius: BorderRadius.circular(14)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                      Icons.person_2_rounded,
                                      color: AppColors.primaryBlue
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.list[index].name ?? '-',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: AppColors.textBlack,
                                            ),
                                          ),
                                          SizedBox(height: 2,),
                                          Text(
                                            state.list[index].email ?? '-',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: AppColors.textBlack,
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  SizedBox(width: 20,),
                                  InkWell(
                                    onTap: (){
                                      context.pushNamed(
                                        RouteNames.adminReassignSurveyorsScreen,
                                        queryParameters: {
                                          'name': state.list[index].name,
                                          'surveyorId': state.list[index].id,
                                          'email': state.list[index].email
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle
                                      ),
                                      child: const Icon(Icons.arrow_forward_ios, color: AppColors.primaryBlue),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
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
}
