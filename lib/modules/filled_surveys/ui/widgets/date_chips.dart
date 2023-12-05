import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';

class DateChips extends StatefulWidget {
  final ValueNotifier<int> dateSelector;
  const DateChips({super.key, required this.dateSelector});

  @override
  State<DateChips> createState() => _DateChipsState();
}

class _DateChipsState extends State<DateChips> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: choiceChips(),
      ),
    );
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i <  ArrayResources.dates.length; i++) {
      Widget item = ValueListenableBuilder(
        valueListenable: widget.dateSelector,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                ArrayResources.dates[i],
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: widget.dateSelector.value == i ? AppColors.primary : AppColors.textBlack
                ),
              ),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: AppColors.primaryBlueBackground,
              selected: widget.dateSelector.value == i,
              selectedColor: AppColors.primaryBlue,
              onSelected: (bool value) {
                widget.dateSelector.value = i;
              },
            ),
          );
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
