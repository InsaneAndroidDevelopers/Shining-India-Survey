import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/build_option.dart';

class OptionWidget extends StatefulWidget {
  final List<String> options;
  final bool isMultiCorrect;
  final bool isFixed;
  final bool isSlider;

  const OptionWidget(
      {super.key, required this.options, required this.isMultiCorrect, required this.isFixed, required this.isSlider,});

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {

  late List<int> selectedOptionsList;
  int selectedIndex = -1;
  double currentValue = 0;
  List<String> emojis = ['😃', '🙂', '🤨', '😟', '😠'];
  final othersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedOptionsList = List.generate(widget.options.length, (index) => 0);
  }

  @override
  void dispose() {
    super.dispose();
    othersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyBloc, SurveyState>(
      listener: (context, state) {
        if(state is SurveyCheckCurrentResponseState) {
          if(widget.isMultiCorrect) {
            context.read<SurveyBloc>().updateAnswerList(selectedOptionsList, othersController.text);
          } else if(widget.isSlider) {
            context.read<SurveyBloc>().updateAnswer(currentValue.toInt());
          } else if(widget.isFixed && selectedIndex != -1){
            context.read<SurveyBloc>().updateAnswer(selectedIndex);
          }
        }
      },
      child: Column(
        children: [
          widget.isSlider
              ? Column(
            children: [
              Text(
                '${emojis[currentValue.toInt()]}\n${widget.options[currentValue.toInt()]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 8,

                ),
                child: Slider(
                  min: 0,
                  max: 4,
                  divisions: widget.options.length - 1,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                  value: currentValue,
                ),
              ),
            ],
          )
              : Expanded(
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                     setState(() {
                      widget.isMultiCorrect
                          ? selectedOptionsList[index] == 0
                          ? selectedOptionsList[index] = 1
                          : selectedOptionsList[index] = 0
                          : selectedIndex = index;
                    });
                  },
                  child: BuildOption(
                      option: widget.options[index],
                      isSelected: widget.isMultiCorrect
                          ? selectedOptionsList[index] != 0
                          : selectedIndex == index
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          if (!widget.isFixed)
            TextField(
              controller: othersController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Others',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4)
              ),
            )
        ],
      ),
    );
  }
}
