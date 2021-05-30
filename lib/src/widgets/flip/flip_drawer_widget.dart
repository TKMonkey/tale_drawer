part of '../tale_widget.dart';

/// {@template flip_drawer_widget}
///
/// This State for an [TaleDrawer] implementing the one `type` of drawer
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the flip
/// In this case
///
/// All types of widgets split the widget into different atomic widgets
/// In this case we split in `body` and `content`
///
/// We only define specific values/variables to complete the proposed
///
///
/// `rotate`: Flip have two specific types, when is Static dont rotate the `content`
/// `translate`: Flip have two specific types, when is Static dont translate the `content`
/// `addSizeInRight`: When [SideState] is right
///  add MediaQuery.of(context).size.width to `TKMDragHelper`
///
/// {@endtemplate}
class _FlipDrawerWidget extends _TaleDrawerState {
  late Animation<double> animationTranslate;
  late Animation<Color?> animationColor;

  double rotate = 1.0;
  late double translate;
  late double addSizeInRight;

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
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Stack(
            children: [
              FlipContent(
                animation: animationTranslate,
                animationColor: animationColor,
                settings: settings,
                delta: delta,
                rotate: rotate,
                isLeftSide: isLeftSide,
                addSizeInRight: addSizeInRight,
                translate: translate,
                onStart: () {
                  if (isAnimationOpen && settings.toggleToClose) {
                    start();
                  }
                },
                drawerContent: widget.drawer,
              ),
              FlipBody(
                animation: animationTranslate,
                animationColor: animationColor,
                delta: delta,
                isLeftSide: isLeftSide,
                settings: settings,
                body: widget.body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initAnimations() {
    animationTranslate = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    animationColor = ColorTween(
      end: settings.shadowColor,
      begin: Colors.transparent,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void initControllFlags() {
    delta = isLeftSide ? 1.0 : -1.0;
    translate = isLeftSide ? 1.0 : 0.0;
    addSizeInRight = isLeftSide ? 0.0 : 1.0;

    if (settings.type != DrawerAnimation.FLIP) {
      rotate = 0.0;
    }
  }

  @override
  void initDragUtils(Size size) {
    final removeSize = !isLeftSide ? 0.0 : 1.0;

    dragUtils = TKMDragHelper(
      animationController: animationController,
      maxSlide: settings.drawerWidth,
      maxDragStartEdge: size.width * removeSize - delta * settings.drawerWidth,
      minDragStartEdge: addSizeInRight * size.width + delta * 60,
      dissableDrag: settings.disableDrag,
      direction:
          isLeftSide ? DragDirection.LeftToRight : DragDirection.RigthtToLeft,
    );
  }

  @override
  FlipSettings get settings =>
      (widget.settings ?? const FlipSettings()) as FlipSettings;
}
