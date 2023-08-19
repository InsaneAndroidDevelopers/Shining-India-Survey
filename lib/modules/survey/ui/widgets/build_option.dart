import 'package:flutter/material.dart';

class BuildOption extends StatefulWidget {
  final String option;
  final bool isSelected;
  const BuildOption({super.key, required this.option, required this.isSelected});

  @override
  State<BuildOption> createState() => _BuildOptionState();
}

class _BuildOptionState extends State<BuildOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: widget.isSelected ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Text(
            widget.option,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              color: widget.isSelected ? Colors.white : Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
