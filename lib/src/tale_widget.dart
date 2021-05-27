import 'package:flutter/material.dart';
import 'package:tale_drawer/src/widgets/old/guillotine/guillotine_settings.dart';

import 'config/tale_settings.dart';
import 'config/tale_style.dart';
import 'controller/animation_controller_mixin.dart';

part 'widgets/flip_drawer_widget.dart';
part 'widgets/guillotine_drawer_widget.dart';
part 'widgets/zoom_drawer_widget.dart';

class TaleWidget extends StatefulWidget {
  const TaleWidget.flip({
    Key? key,
    required this.drawer,
    required this.body,
    this.settings = const GuillotineSettings(),
  })  : type = TaleType.Flip,
        super(key: key);

  const TaleWidget.guillotine({
    Key? key,
    required this.drawer,
    required this.body,
    this.settings = const GuillotineSettings(),
  })  : type = TaleType.Guillotine,
        super(key: key);

  const TaleWidget.zoom({
    Key? key,
    required this.drawer,
    required this.body,
    this.settings = const GuillotineSettings(),
  })  : type = TaleType.Zoom,
        super(key: key);

  final Widget drawer;
  final Widget body;
  final TaleSettings settings;
  final TaleType type;

  @override
  TaleWidgetState createState() {
    return ZoomDrawerWidget();
  }
}

abstract class TaleWidgetState extends State<TaleWidget>
    with SingleTickerProviderStateMixin, AnimationControllerMixin {}
