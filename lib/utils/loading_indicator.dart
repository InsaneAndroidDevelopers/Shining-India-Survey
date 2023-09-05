import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Widget child;
  const LoadingIndicator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.withOpacity(0.2),
      child: Center(
        child: child,
      ),
    );
  }
}
