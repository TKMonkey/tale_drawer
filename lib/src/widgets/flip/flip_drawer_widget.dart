part of '../tale_widget.dart';

class FlipDrawerWidget extends TaleDrawerState {
  late Animation<double> animationFlip;
  late Animation<double> animationTranslate;

  double rotate = 1.0;
  late double translate;
  late double wSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            FlipContent(
              animationTranslate: animationTranslate,
              animationFlip: animationFlip,
              type: settings.type,
              delta: delta,
              rotate: rotate,
              centerAligment: centerAligment,
              drawerWidth: settings.drawerWidth,
              wSize: wSize,
              translate: translate,
              drawerContent: widget.drawer,
            ),
            GestureDetector(
              onTap: () {
                if (isDrawerOpen && settings.toggleToClose) {
                  start();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: FlipBody(
                animationTranslate: animationTranslate,
                animationFlip: animationFlip,
                delta: delta,
                drawerWidth: settings.drawerWidth,
                centerAligment: centerAligment,
                body: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initAnimations() {
    animationFlip =
        Tween(begin: 0.0, end: (settings.flipPercent / 100) * math.pi / 2)
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationTranslate = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
  }

  @override
  void initControllFlags() {
    delta = isLeftSide ? 1.0 : -1.0;
    translate = isLeftSide ? 1.0 : 0.0;
    wSize = delta * translate - delta;

    if (settings.type != DrawerAnimation.FLIP) {
      rotate = 0.0;
    }
  }

  @override
  FlipSettings get settings =>
      (widget.settings ?? const FlipSettings()) as FlipSettings;
}
