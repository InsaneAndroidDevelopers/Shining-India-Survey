import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';

class GenderChips extends StatefulWidget {
  const GenderChips({super.key});

  @override
  State<GenderChips> createState() => _GenderChipsState();
}

class _GenderChipsState extends State<GenderChips> {
  int _selectedIndex = 0;

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
        child: ChoiceChip(
          label: Text(
            ArrayResources.genders[i],
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: _selectedIndex == i ? AppColors.primary : AppColors.textBlack
            ),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: AppColors.primaryBlueBackground,
          selected: _selectedIndex == i,
          selectedColor: AppColors.primaryBlue,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}