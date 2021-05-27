import 'tale_settings.dart';

class FlipSettings implements TaleSettings {
  const FlipSettings({
    this.drawerWidth = 250.0,
    this.flipPercent = 99,
    this.toggleToClose = true,
    this.type = DrawerAnimation.FLIP,
  }) : assert(flipPercent >= 75 && flipPercent <= 100);

  final double drawerWidth;
  final double flipPercent;
  final bool toggleToClose;
  final DrawerAnimation type;

  @override
  Duration get duration => const Duration(milliseconds: 700);
}

enum DrawerAnimation {
  STATIC,
  TRANSLATE,
  FLIP,
}
