import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWrapper extends StatelessWidget {
  final Color backgroundColor;
  final Function()? onTap;
  final Widget child;

  const CardWrapper(
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
