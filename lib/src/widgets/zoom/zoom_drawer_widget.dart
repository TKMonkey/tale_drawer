part of '../tale_widget.dart';

/// {@template zoom_drawer_widget}
///
/// This State for an [TaleDrawer] implementing the one `type` of drawer
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the zoom
/// In this case
///
/// All types of widgets split the widget into different atomic widgets
/// In this case we split in `body` and `content`
///
/// We only define specific values/variables to complete the proposed
///
/// {@endtemplate}
class ZoomDrawerWidget extends TaleDrawerState<ZoomSettings> {
  ZoomDrawerWidget(ZoomSettings settings) : super(settings);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    initControllFlags();
    initDragUtils(size);

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: dragUtils.onDragStart,
        onHorizontalDragUpdate: dragUtils.onDragUpdate,
        onHorizontalDragEnd: dragUtils.onDragEnd,
        child: Stack(
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
  void initDragUtils(Size size) {
    final addMaxSize = isLeftSide ? 1.0 : 0.0;

    dragUtils = TKMDragHelper(
      animationController: animationController,
      maxSlide: settings.maxSlide,
      maxDragStartEdge: settings.maxSlide,
      minDragStartEdge: addMaxSize * size.width + delta * 60,
      dissableDrag: settings.disableDrag,
      direction:
          isLeftSide ? DragDirection.RigthtToLeft : DragDirection.LeftToRight,
    );
  }

  double slideSize(double width) => settings.maxSlide + addRotationSlide(width);

  double addRotationSlide(double width) =>
      width * settings.rotation.abs() / 100;
}
