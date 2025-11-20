import 'package:flutter/material.dart';

class ScreenOutline extends StatelessWidget {
  const ScreenOutline({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.drawer,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
