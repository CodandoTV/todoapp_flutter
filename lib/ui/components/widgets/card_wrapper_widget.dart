import 'package:flutter/material.dart';

class CardWrapperWidget extends StatelessWidget {
  final Color backgroundColor;
  final Function()? onTap;
  final Widget child;
  final ShapeBorder? shapeBorder;
  final double? elevation;

  static const commonShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const commonElevation = 2.0;

  const CardWrapperWidget({
    super.key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    this.elevation,
    this.shapeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: shapeBorder,
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
