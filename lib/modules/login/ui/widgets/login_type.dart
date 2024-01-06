import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';

class LoginType extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const LoginType(
      {super.key,
        required this.image,
        required this.text,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: image,
          child: Image.asset(
            image,
            height: 180,
          ),
        ),
        CustomButton(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: AppColors.primary,
                fontWeight: FontWeight.w600
            ),
          )
        )
      ],
    );
  }
}