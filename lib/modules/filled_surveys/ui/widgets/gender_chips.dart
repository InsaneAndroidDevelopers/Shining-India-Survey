import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/values/array_res.dart';

class GenderChips extends StatefulWidget {
  final ValueNotifier<int> selectedIndex;

  const GenderChips({super.key, required this.selectedIndex});

  @override
  State<GenderChips> createState() => _GenderChipsState();
}

class _GenderChipsState extends State<GenderChips> {

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
    for (int i = 0; i <  ArrayResources.genders.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ValueListenableBuilder(
          valueListenable: widget.selectedIndex,
          builder: (context, value, child) {
            return ChoiceChip(
              label: Text(
                ArrayResources.genders[i],
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: widget.selectedIndex.value == i ? AppColors.primary : AppColors.textBlack
                ),
              ),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: AppColors.primaryBlueBackground,
              selected: widget.selectedIndex.value == i,
              selectedColor: AppColors.primaryBlue,
              onSelected: (bool value) {
                widget.selectedIndex.value = i;
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