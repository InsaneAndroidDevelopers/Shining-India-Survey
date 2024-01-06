import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class DropDownTextField extends StatefulWidget {
  final Icon prefixIcon;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const DropDownTextField({
    super.key,
    required this.prefixIcon,
    this.value,
    this.items,
    this.onChanged
  });

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightBlack),
      borderRadius: BorderRadius.circular(16)
    );
    return DropdownButtonFormField(
      isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: widget.prefixIcon,
          border: outlineBorder,
          disabledBorder: outlineBorder,
          errorBorder: outlineBorder,
          focusedBorder: outlineBorder,
          focusedErrorBorder: outlineBorder,
          enabledBorder: outlineBorder,
        ),
      items: widget.items,
      onChanged: widget.onChanged
    );
  }
}
