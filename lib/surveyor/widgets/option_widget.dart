import 'package:flutter/material.dart';
import 'package:shining_india_survey/surveyor/widgets/build_option.dart';

class OptionWidget extends StatefulWidget {
  final List<String> options;
  final bool isMultiCorrect;
  const OptionWidget({super.key, required this.options, required this.isMultiCorrect,});

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {

  late List<int> selectedOptionsList;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedOptionsList = List.generate(widget.options.length, (index) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.options.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
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
            isSelected: widget.isMultiCorrect ? selectedOptionsList[index] != 0 : selectedIndex == index
          ),
        );
      },
    );
  }
}
