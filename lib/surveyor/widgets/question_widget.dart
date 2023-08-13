import 'package:flutter/material.dart';
import 'package:shining_india_survey/models/Question.dart';
import 'package:shining_india_survey/surveyor/widgets/option_widget.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              widget.question.questionText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 18,),
          Expanded(
            child: OptionWidget(
              options: widget.question.options,
              isMultiCorrect: widget.question.isMultiCorrect,
            )
          ),
        ],
      )
    );
  }
}