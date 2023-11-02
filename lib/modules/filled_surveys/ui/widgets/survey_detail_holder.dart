import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class SurveyDetailHolder extends StatelessWidget {
  final String name;
  final String val;
  const SurveyDetailHolder({super.key, required this.name, required this.val});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
                name,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'
                )
              ),
            ),
          ),
          SizedBox(width: 4),
          Text(
            ':'
          ),
          SizedBox(width: 4),
          Expanded(
            flex: 4,
            child: Container(
              child: Text(
                val,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
