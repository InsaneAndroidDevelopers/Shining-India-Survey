import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/login/ui/widgets/login_type.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginType(
                    onTap: () {
                      context.push(RouteNames.adminLoginScreen);
                    },
                    image: 'assets/admin.png',
                    text: 'Login as admin'
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.dividerColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: AppColors.dividerColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  LoginType(
                    onTap: (){
                      context.push(RouteNames.surveyorLoginScreen);
                    },
                    image: 'assets/user.png',
                    text: 'Login as surveyor'
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
