import 'package:tale_drawer/src/widgets/tale_drawer_state.dart';
import 'package:tale_drawer/src/widgets/tale_widget.dart';

import '../../tale_drawer.dart';
import 'tale_settings.dart';

/// {@template guillotine_settings}
///
/// Data class to handle the particular settings for [ZoomDrawerWidget]
/// This class help a [TaleDrawer] to build the `Drawer` and define some special characteristics
///
/// {@endtemplate}
class ZoomSettings implements TaleSettings {
  const ZoomSettings({
    this.settings,
    this.maxSlide = 250,
    this.radius = 34,
    this.rotation = 0.0,
    this.disableDrag = false,
    this.addHeightScale = 0.0,
  })  : assert(rotation >= -15.0 && rotation <= 15),
        assert(addHeightScale >= 0.0 && addHeightScale <= 0.3);

  final TaleSettings? settings;

  /// The maximum position when drag is end
  final double maxSlide;

  /// To create a border radius when [ZoomDrawerBody] is dragged
  final double radius;

  /// Create a rotation in body when drag is end
  final double rotation;

  /// Change the scale for the height in [ZoomDrawerBody] when is dragged
  final double addHeightScale;

  /// Flag to control de drag to open or close in the `Drawer`
  final bool disableDrag;

  @override
  Duration get duration => const Duration(milliseconds: 400);

  @override
  ZoomDrawerWidget createState() => ZoomDrawerWidget(this);
}
