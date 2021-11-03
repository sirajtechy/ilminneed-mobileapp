import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Function? onTap;
  final String? hint;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final BoxShadow? boxShadow;

  CustomAppBar({
    this.titleWidget,
    this.actions,
    this.leading,
    this.onTap,
    this.hint,
    this.bottom,
    this.color,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      leading: leading,
      title: titleWidget,
      actions: actions,
      bottom: bottom ??
          PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Text('test'),
          ),
    );
  }
}
