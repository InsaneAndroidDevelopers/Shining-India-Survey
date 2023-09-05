import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_surveyor_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';

class AdminSurveyorScreen extends StatefulWidget {
  const AdminSurveyorScreen({super.key});

  @override
  State<AdminSurveyorScreen> createState() => _AdminSurveyorScreenState();
}

class _AdminSurveyorScreenState extends State<AdminSurveyorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Name'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return AdminSurveyorWidget(
                      onTap: () {
                        context.pushNamed(
                          RouteNames.adminCreateUpdateSurveyorScreen,
                          queryParameters: {
                            'isUpdate': 'true',
                            'name': 'Dummy'
                          }
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(
            RouteNames.adminCreateUpdateSurveyorScreen,
            queryParameters: {
              'isUpdate': 'false',
              'name': ''
            }
          );
        },
        icon: Icon(Icons.add),
        label: Text('Create Surveyor'),
      ),
    );
  }
}
