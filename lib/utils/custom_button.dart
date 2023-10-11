import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

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
              Color(0xFF1c8ca4),
              Color(0xFF8bd6ed),
            ]
          ),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: AppColors.primary,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
