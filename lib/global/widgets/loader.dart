import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: AppColors.white,
      ),
    );
  }
}
