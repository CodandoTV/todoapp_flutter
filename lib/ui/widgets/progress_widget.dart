import 'package:flutter/material.dart';

const double containerHeight = 9.0;

class ProgressWidget extends StatelessWidget {
  late final double _progress;

  /// progress should be at max 1
  ProgressWidget({super.key, required double progress}) {
    _progress = progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => _buildProgressBar(
            progress: _progress,
            maxWidth: constraints.maxWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(
      {required double progress, required double maxWidth}) {
    final double endWidth = maxWidth * progress;
    Color decorationColor = Colors.blueAccent;

    if (progress == 1) {
      decorationColor = Colors.green;
    }

    return Container(
      width: endWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: decorationColor,
      ),
    );
  }
}
