import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class QuestionResponseHolder extends StatelessWidget {
  final String questionText;
  final List<String> answers;
  const QuestionResponseHolder({super.key, required this.questionText, required this.answers});

  String _convertToString(List<String> list) {
    if(list.isNotEmpty) {
      String answers = '';
      for (var element in list) {
        answers += "$element\n";
      }
      return answers.trim();
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBlueLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'
            )
          ),
          Divider(color: AppColors.dividerColor,),
          Text(
            _convertToString(answers),
            style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'
            )
          ),
        ],
      ),
    );
  }
}
