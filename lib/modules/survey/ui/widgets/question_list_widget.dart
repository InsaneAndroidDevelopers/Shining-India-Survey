import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';

import 'option_list_widget.dart';
import 'option_widget.dart';

class QuestionListWidget extends StatefulWidget {
  final QuestionModel question;
  const QuestionListWidget({super.key, required this.question});

  @override
  State<QuestionListWidget> createState() => _QuestionListWidgetState();
}

class _QuestionListWidgetState extends State<QuestionListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.question.question ?? '',
            style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: AppColors.primary
            ),
          ),
          SizedBox(height: 14,),
          OptionListWidget(
            question: widget.question,
          ),
        ],
      )
    );
  }
}
