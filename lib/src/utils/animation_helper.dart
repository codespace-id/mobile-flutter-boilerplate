import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension AnimateWidget on Widget {
  Widget get shimmerEffect {
    return animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(
      angle: pi / 7,
      duration: const Duration(seconds: 1),
      color: Colors.grey[300],
    );
  }

  Widget get fadeInEffect {
    return animate().fadeIn(
      duration: Duration(milliseconds: 1000),
    );
  }

  Widget get fadeOutEffect {
    return animate().fadeOut(
      duration: Duration(milliseconds: 1000),
    );
  }
}
