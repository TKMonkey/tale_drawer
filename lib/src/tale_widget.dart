import 'package:flutter/material.dart';

import 'config/config.dart';
import 'controller/animation_controller_mixin.dart';
import 'controller/tale_controller.dart';
import 'misc/drawer_listener.dart';

part 'widgets/flip_drawer_widget.dart';
part 'widgets/guillotine_drawer_widget.dart';
part 'widgets/zoom_drawer_widget.dart';

class TaleDrawer extends StatefulWidget {
  const TaleDrawer({
    Key? key,
    required this.type,
    required this.drawer,
    required this.body,
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.settings,
    this.listener,
    this.controller,
  })  : assert(settings == null ||
            (type == TaleType.Flip && settings is FlipSettings) ||
            (type == TaleType.Guillotine && settings is GuillotineSettings) ||
            (type == TaleType.Zoom && settings is ZoomSettings)),
        super(key: key);

  final TaleType type;
  final Widget drawer;
  final Widget body;
  final SideState sideState;
  final DrawerState drawerState;
  final TaleSettings? settings;
  final DrawerListener? listener;
  final TaleController? controller;

  @override
  // ignore: no_logic_in_create_state
  TaleDrawerState createState() {
    switch (type) {
      case TaleType.Flip:
        return FlipDrawerWidget();
      case TaleType.Guillotine:
        return GuillotineDrawerWidget();
      case TaleType.Zoom:
        return ZoomDrawerWidget();
    }
  }
}

abstract class TaleDrawerState extends State<TaleDrawer>
    with SingleTickerProviderStateMixin, AnimationControllerMixin {
  void initSettingsValues() {}
}
