part of '../tale_widget.dart';

class ZoomDrawerWidget extends TaleDrawerState {
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: widget.drawerBackground,
          child: widget.drawer,
        ),
      ],
    );
  }

  @override
  void initAnimations() {}

  @override
  void initControllFlags() {
    animationController.value = !isStartedOpen ? 0.0 : 1.0;
    delta = isLeftSide ? 1.0 : -1.0;
  }

  @override
  ZoomSettings get settings =>
      (widget.settings ?? const ZoomSettings()) as ZoomSettings;
}
