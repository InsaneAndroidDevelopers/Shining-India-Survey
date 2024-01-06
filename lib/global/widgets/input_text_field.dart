import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class InputTextField extends StatelessWidget {
  final Key formKey;
  final TextEditingController textEditingController;
  final TextInputType keyboardInputType;
  final String label;
  final Icon prefixIcon;
  final IconButton? suffixIconButton;
  final AutovalidateMode autoValidateMode;
  final String? Function(String? value) validator;

  const InputTextField({
    super.key,
    required this.formKey,
    required this.textEditingController,
    required this.keyboardInputType,
    required this.label,
    required this.prefixIcon,
    required this.autoValidateMode,
    required this.validator,
    this.suffixIconButton
  });

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightBlack),
      borderRadius: BorderRadius.circular(16)
    );
    return TextFormField(
      key: formKey,
      controller: textEditingController,
      cursorColor: AppColors.lightBlack,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.lightBlack
        ),
        suffixIcon: suffixIconButton,
        border: outlineBorder,
        disabledBorder: outlineBorder,
        errorBorder: outlineBorder,
        focusedBorder: outlineBorder,
        focusedErrorBorder: outlineBorder,
        enabledBorder: outlineBorder,
      ),
      autovalidateMode: autoValidateMode,
      validator: validator,
    );
  }
}
