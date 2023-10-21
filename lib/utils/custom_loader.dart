import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  final BuildContext context;
  const CustomLoader({required this.context});

  show() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Lottie.asset(
            'assets/loading.json',
            width: 150,
            height: 150,
          ),
        );
      },
    );
  }
}
