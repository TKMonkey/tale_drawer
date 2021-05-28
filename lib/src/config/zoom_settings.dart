import 'tale_settings.dart';

class ZoomSettings implements TaleSettings {
  const ZoomSettings({
    this.maxSlide = 250,
    this.radius = 34,
    this.rotation = 0.0,
    this.disableDrag = false,
    this.addHeightScale = 0.0,
  })  : assert(rotation >= -15.0 && rotation <= 15),
        assert(addHeightScale >= 0.0 && addHeightScale <= 0.3);

  final double maxSlide;
  final double radius;
  final double rotation;
  final double addHeightScale;
  final bool disableDrag;

  @override
  Duration get duration => const Duration(milliseconds: 400);
}
