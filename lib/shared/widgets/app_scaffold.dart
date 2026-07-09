import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.bottomNavigationBar,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: title != null
            ? AppBar(
                title: Text(title!),
                actions: actions,
                leading: leading,
              )
            : null,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
