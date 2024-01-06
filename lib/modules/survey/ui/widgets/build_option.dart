import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class BuildOption extends StatefulWidget {
  final String option;
  final bool isSelected;
  const BuildOption({super.key, required this.option, required this.isSelected});

  @override
  State<BuildOption> createState() => _BuildOptionState();
}

class _BuildOptionState extends State<BuildOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.green : AppColors.primary,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.option,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Poppins',
                color: widget.isSelected ? AppColors.white : AppColors.textBlack
              ),
            ),
          ),
          widget.isSelected? Container(
            padding: EdgeInsets.all(1),
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle
            ),
            child: Icon(Icons.done, color: AppColors.green, size: 20,)
          ) : Container(),
        ],
      ),
    );
  }
}
