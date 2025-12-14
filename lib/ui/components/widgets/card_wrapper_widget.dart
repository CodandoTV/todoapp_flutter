import 'package:flutter/material.dart';

class CardWrapperWidget extends StatelessWidget {
  final Color backgroundColor;
  final Function()? onTap;
  final Widget child;

  const CardWrapperWidget(
      {super.key,
      required this.child,
      required this.onTap,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
