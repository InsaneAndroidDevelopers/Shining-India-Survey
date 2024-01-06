import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const CustomButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.primaryBlue,
              AppColors.primaryBlueLight,
            ]
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        child: child,
      ),
    );
  }
}
