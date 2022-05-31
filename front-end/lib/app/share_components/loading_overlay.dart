import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
  }): assert(child != null), super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return child;
    }
  }
}
