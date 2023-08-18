import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/login/core/bloc/login_bloc.dart';
import 'package:shining_india_survey/modules/login/ui/admin_login_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)
                  ),
                  onPressed: () {
                    context.push(RouteNames.adminLoginScreen);
                  },
                  child: Text(
                    'Login As Admin',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)
                  ),
                  onPressed: () {
                    context.push(RouteNames.surveyorLoginScreen);
                  },
                  child: Text(
                    'Login As Surveyor',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
