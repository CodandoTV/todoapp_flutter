import 'package:flutter/material.dart';

class CardWrapperWidget extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final ShapeBorder? shapeBorder;
  final double? elevation;
  final bool? isSelected;

  const CardWrapperWidget({
    super.key,
    required this.child,
    required this.onTap,
    this.elevation,
    this.shapeBorder,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected == true) {
      return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        color: Theme.of(context).colorScheme.tertiaryContainer,
        clipBehavior: Clip.hardEdge,
        child: child,
      );
    } else {
      return Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).colorScheme.surfaceBright,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      );
    }
  }
}
