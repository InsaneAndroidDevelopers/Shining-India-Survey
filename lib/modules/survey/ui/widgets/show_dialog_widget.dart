import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/routes/routes.dart';

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              elevation: 4,
              color: AppColors.primaryBlueLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.go(RouteNames.surveyListScreen);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            maxRadius: 30,
                            minRadius: 10,
                            child: Image.asset('assets/vertical.png', color: AppColors.black,),
                          ),
                        ),
                        SizedBox(height: 4,),
                        const Text(
                          'Vertical',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.go(RouteNames.surveyScreen);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            maxRadius: 30,
                            minRadius: 10,
                            child: Image.asset('assets/horizontal.png', color: AppColors.black,),
                          ),
                        ),
                        SizedBox(height: 4,),
                        const Text(
                          'Horizontal',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}