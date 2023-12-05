import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class CustomFlushBar {
  final String message;
  final Icon? icon;
  final Color backgroundColor;
  final BuildContext context;

  CustomFlushBar({required this.message, required this.icon, required this.backgroundColor, required this.context});

  show() async {
    Flushbar(
      margin: EdgeInsets.all(6),
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.primary,
          fontSize: 14
        )
      ),
      borderRadius: BorderRadius.circular(10),
      duration: Duration(milliseconds: 1500),
      backgroundColor: backgroundColor,
      isDismissible: true,
      icon: icon,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }
}