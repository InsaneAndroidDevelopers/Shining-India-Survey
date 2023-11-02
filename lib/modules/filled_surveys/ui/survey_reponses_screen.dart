import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/question_reponse_holder.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';

class SurveyResponsesScreen extends StatelessWidget {
  final List<QuestionResponseModel> responses;
  const SurveyResponsesScreen({super.key, required this.responses});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                      onTap: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return QuestionResponseHolder(
                      questionText: responses[index].questionId ?? '',
                      answers: responses[index].answer ?? []
                    );
                  },
                  itemCount:  responses.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
