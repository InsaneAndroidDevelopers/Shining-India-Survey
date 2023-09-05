import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        icon: Icon(Icons.add),
        label: Text('Create team'),
      ),
    );
  }
}
