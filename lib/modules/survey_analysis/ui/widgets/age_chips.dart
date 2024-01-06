import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';

class AgeChips extends StatefulWidget {
  final ValueNotifier<int> ageIndex;
  const AgeChips({super.key, required this.ageIndex});

  @override
  State<AgeChips> createState() => _AgeChipsState();
}

class _AgeChipsState extends State<AgeChips> {

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
    for (int i = 0; i <  ArrayResources.ageGroup.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ValueListenableBuilder(
          valueListenable: widget.ageIndex,
          builder: (context, value, child) {
            return ChoiceChip(
              label: Text(
                ArrayResources.ageGroup[i],
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: widget.ageIndex.value == i ? AppColors.primary : AppColors.textBlack
                ),
              ),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: AppColors.primaryBlueBackground,
              selected: widget.ageIndex.value == i,
              selectedColor: AppColors.primaryBlue,
              onSelected: (bool value) {
                widget.ageIndex.value = i;
              },
            );
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
