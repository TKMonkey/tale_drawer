import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';
import 'package:tale_drawer/src/controller/tale_controller.dart';
import 'package:tale_drawer/src/misc/tale_listener.dart';
import 'package:tale_drawer/src/widgets/tale_drawer_state.dart';

/// {@template tale_widget}
///
/// Set the definition for drawer and configure the params to have a different options
///
/// This widget transform the `type` into a `Flip`, `Guillotine` or `Zoom`
/// And define the states to change the animation behavior
///
/// `delta`: Depends of the [SideState] delta is positive or negative to change the animation behavior
/// with this param you manipulate the direction or the animation
///
/// `dragUtils`: Is the helper to drag the `Flip` or `Zoom`
///
/// {@endtemplate}
class TaleDrawer extends StatefulWidget {
  const TaleDrawer({
    Key? key,
    required this.drawer,
    required this.body,
    required this.settings,
    this.drawerBackground = const Color(0xff2E2C3C),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.listener,
    this.controller,
  }) : super(key: key);

  /// The widget that represented the content in the drawer
  final Widget drawer;

  /// The Widget displayed overtop the `drawer`, like Scaffold body
  final Widget body;

  /// Background of drawer content widget
  final Color drawerBackground;

  /// Chooose between Left and Right side to change animation direction
  final SideState sideState;

  /// Choose the drawer start open or close
  final DrawerState drawerState;

  /// Set specific settings for the type of `drawer`, help to set a custom behavior for `TaleDrawer`
  final TaleSettings settings;

  /// Set listener to get updates, of changes in state
  final TaleListener? listener;

  /// Create a custom controller to control the animation behavior and state  of the `drawer`
  final TaleController? controller;

  @override
  // ignore: no_logic_in_create_state
  TaleDrawerState createState() => settings.createState();
}
