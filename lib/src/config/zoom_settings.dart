import 'tale_settings.dart';

class ZoomSettings implements TaleSettings {
  const ZoomSettings({
    this.maxSlide = 250,
    this.radius = 34,
    this.rotation = 0.0,
    this.heightScale = 0.0,
  })  : assert(rotation >= -15.0 && rotation <= 15),
        assert(heightScale >= 0.0 && heightScale <= 0.3);

  final double maxSlide;
  final double radius;
  final double rotation;
  final double heightScale;

  @override
  Duration get duration => const Duration(milliseconds: 700);
}
