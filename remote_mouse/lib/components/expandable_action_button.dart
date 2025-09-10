import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExpandableActionButton extends StatelessWidget {
  const ExpandableActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: progress,
        builder: (context,child){

          final offSet = Offset.fromDirection(
            directionInDegrees * (math.pi / 360.0),
            progress.value * maxDistance
          );

          print(offSet);

          return Positioned(
            right: 4.0 + offSet.dx,
            bottom: 4.0 + offSet.dy,
            child: Transform.rotate(
              angle: (1.0 - progress.value) * math.pi / 2,
              child: child!,
            ),
          );
        },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}
