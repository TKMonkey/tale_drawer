part of '../tale_widget.dart';

class ZoomDrawerWidget extends TaleDrawerState {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ZoomDrawerContent(
            drawerBackground: widget.drawerBackground,
            drawer: widget.drawer,
          ),
          ZoomDrawerBody(
            animationController: animationController,
            slideSize: delta * slideSize(size.width),
            settings: settings,
            centerAligment: centerAligment,
            body: widget.body,
          ),
        ],
      ),
    );
  }

  @override
  void initAnimations() {}

  @override
  void initControllFlags() {
    delta = isLeftSide ? -1.0 : 1.0;
  }

  @override
  ZoomSettings get settings =>
      (widget.settings ?? const ZoomSettings()) as ZoomSettings;

  double slideSize(double width) => settings.maxSlide + addRotationSlide(width);

  double addRotationSlide(double width) =>
      width * settings.rotation.abs() / 100;
}
