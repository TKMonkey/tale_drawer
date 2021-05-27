import 'package:flutter/material.dart';

import 'tale_settings.dart';

class ZoomSettings implements TaleSettings {
  const ZoomSettings({
    this.maxSlide = 250,
    this.radius = 34,
    this.showShadows = false,
    this.shadowColor = Colors.white,
  });

  final double maxSlide;
  final double radius;
  final bool showShadows;
  final Color shadowColor;

  @override
  Duration get duration => const Duration(milliseconds: 700);
}
