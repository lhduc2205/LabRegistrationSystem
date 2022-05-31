import 'package:flutter/material.dart';

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({Key? key, required this.isLoading, required this.child}) : super(key: key);
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return const CircularProgressIndicator();
    } else {
      return child;
    }
  }
}
