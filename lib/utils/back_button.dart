import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.dividerColor
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_back_ios_rounded, color: AppColors.black),
        ),
      ),
    );
  }
}
