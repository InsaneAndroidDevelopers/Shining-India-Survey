import 'package:flutter/material.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/option_widget.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class QuestionWidget extends StatefulWidget {
  final QuestionModel question;
  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            widget.question.question ?? '',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: AppColors.primary
            ),
          ),
          SizedBox(height: 18,),
          Expanded(
            child: OptionWidget(
              question: widget.question,
            )
          ),
        ],
      )
    );
  }
}