import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/build_option.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

class OptionWidget extends StatefulWidget {
  final QuestionModel question;

  const OptionWidget({super.key, required this.question});

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {

  double currentValue = 0;
  final othersController = TextEditingController();
  ValueNotifier<bool> isOthersShown = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    othersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.lightBlack
        ),
        borderRadius: BorderRadius.circular(16)
    );
    return BlocListener<SurveyBloc, SurveyState>(
      listener: (context, state) {

      },
      child: Column(
        children: [
          widget.question.type == StringsConstants.QUES_TYPE_SLIDER
              ? Column(
            children: [
              SizedBox(height: 20,),
              Text(
                '${ArrayResources.emojis[currentValue.toInt()]}\n${widget.question.options?[currentValue.toInt()]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: AppColors.primary,
                  fontSize: 24
                ),
              ),
              SizedBox(height: 10,),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 8,
                  inactiveTrackColor: AppColors.primary,
                  activeTrackColor: AppColors.primaryBlueLight,
                  thumbColor: AppColors.primaryBlue
                ),
                child: Slider(
                  min: 0,
                  max: 4,
                  divisions: (widget.question.options?.length ?? 1) - 1 ,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                      widget.question.selectedIndex = value.toInt();
                    });
                  },
                  value: currentValue,
                ),
              ),
            ],
          )
              : Expanded(
            child: ListView.builder(
              itemCount: widget.question.options?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                     setState(() {
                       if(widget.question.type == StringsConstants.QUES_TYPE_MULTI) {
                         if(widget.question.selectedOptions[index] == 0) {
                           widget.question.selectedOptions[index] = 1;
                         } else {
                           widget.question.selectedOptions[index] = 0;
                         }
                         if(widget.question.options?[index].toLowerCase() == 'others' ||
                             widget.question.options?[index].toLowerCase() == 'other') {
                           if(isOthersShown.value == true) {
                             isOthersShown.value = false;
                             othersController.text = '';
                           } else {
                             isOthersShown.value = true;
                           }
                         }
                       } else if(widget.question.type == StringsConstants.QUES_TYPE_SINGLE) {
                         widget.question.selectedIndex = index;
                         if(widget.question.options?[index].toLowerCase() == 'others' ||
                             widget.question.options?[index].toLowerCase() == 'other') {
                           if(isOthersShown.value == true) {
                             isOthersShown.value = false;
                             othersController.text = '';
                           } else {
                             isOthersShown.value = true;
                           }
                         }
                       }
                    });
                  },
                  child: BuildOption(
                      option: widget.question.options?[index] ?? '',
                      isSelected: widget.question.type == StringsConstants.QUES_TYPE_MULTI
                          ? widget.question.selectedOptions[index] != 0
                          : widget.question.selectedIndex == index
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
            ValueListenableBuilder(
              valueListenable: isOthersShown,
              builder: (context, value, child) {
                if(isOthersShown.value) {
                  return TextField(
                    controller: othersController,
                    onChanged: (value){
                        widget.question.otherText = othersController.text;
                        print(widget.question.otherText);
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: AppColors.textBlack
                    ),
                    cursorColor: AppColors.lightBlack,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      fillColor: AppColors.primary,
                      filled: true,
                      labelText: 'Others',
                      labelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.lightBlack
                      ),
                      border: outlineBorder,
                      disabledBorder: outlineBorder,
                      errorBorder: outlineBorder,
                      focusedBorder: outlineBorder,
                      focusedErrorBorder: outlineBorder,
                      enabledBorder: outlineBorder,
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
        ],
      ),
    );
  }
}
