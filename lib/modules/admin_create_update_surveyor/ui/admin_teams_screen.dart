import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_team_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/back_button.dart';

class AdminTeamsScreen extends StatefulWidget {
  const AdminTeamsScreen({super.key});

  @override
  State<AdminTeamsScreen> createState() => _AdminTeamsScreenState();
}

class _AdminTeamsScreenState extends State<AdminTeamsScreen> {

  final teamController = TextEditingController();

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
                      onTap: (){
                        context.pop();
                      },
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text(
                        'Your teams',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await openDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.dividerColor
                            ),
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.add, color: AppColors.black),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AdminTeamWidget();
                  },
                  itemCount: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog() async{
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
                prefixIcon: Icon(Icons.people_alt_rounded)
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel')
            ),
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Create')
            ),
          ],
        );
      },
    );
  }
}
