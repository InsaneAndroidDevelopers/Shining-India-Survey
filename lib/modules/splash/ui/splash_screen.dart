import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/splash/core/bloc/splash_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/surveyor_home_screen.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;

  bool animation2Ended = false;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller2.forward();
      }
    });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        BlocProvider.of<SplashBloc>(context).add(FetchUserInfoEvent());
      }
    });

    animation1 = Tween<double>(begin: 6.0, end: 1.0).animate(controller1);
    animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(controller2);

    controller1.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if(state is NavigateToLoginScreen) {
          context.go(RouteNames.loginScreen);
        } else if(state is NavigateToAdminHomeScreen) {
          context.go(RouteNames.adminHomeScreen);
        } else if(state is NavigateToSurveyorHomeScreen) {
          context.go(RouteNames.surveyorHomeScreen);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: animation1,
                  child: Image.asset(
                    'assets/logo.jpeg',
                    height: 200,
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FadeTransition(
                  opacity: animation2,
                  child: const Text(
                    'SHINING INDIA\nRESEARCH AND ANALYSIS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack
                    ),
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
