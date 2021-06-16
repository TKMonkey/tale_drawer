part of '../tale_drawer_state.dart';

/// {@template guillotine_drawer_widget}
///
/// This State for an [TaleDrawer] implementing the one `type` of drawer
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the guillotine
/// In this case
///
/// All types of widgets split the widget into different atomic widgets
/// In this case we split in `body`, `content`, `appBar` and `menuIcon`
///
/// We only define specific values/variables to complete the proposed
///
/// !This Widget can dragged yet
///
/// {@endtemplate}
class GuillotineDrawerWidget extends TaleDrawerState<GuillotineSettings> {
  late Animation<double> animationGuillotine;
  late Animation<double> animationIcon;
  late Animation<double> animationAppBarOppacity;
  late Animation<double> animationContentOppacity;

  GuillotineDrawerWidget(GuillotineSettings internalSettings)
      : super(internalSettings);

  @override
  Widget build(BuildContext context) {
    initControlFlags();
    final barSize = settings.noAppBar
        ? 0.0
        : MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            widget.body,
            Stack(
              children: [
                GuillotineContent(
                  animationGuillotine: animationGuillotine,
                  animationContentOppacity: animationContentOppacity,
                  barSize: barSize,
                  fixedAppBar: settings.fixedAppBar,
                  topAligment: topAligment,
                  backgroundColor: widget.drawerBackground,
                  delta: delta,
                  drawerContent: widget.drawer,
                ),
                Positioned(
                  left: isLeftSide ? 0.0 : null,
                  right: !isLeftSide ? 0.0 : null,
                  child: GuillotineAppbar(
                    animationAppBarOppacity: animationAppBarOppacity,
                    animationGuillotine: animationGuillotine,
                    barSize: barSize,
                    delta: delta,
                    quarterTurns: isLeftSide ? 0 : 2,
                    topAligment: topAligment,
                    settings: settings,
                  ),
                ),
              ],
            ),
            Positioned(
              left: isLeftSide ? 0.0 : null,
              right: !isLeftSide ? 0.0 : null,
              child: GuillotineMenuIcon(
                animationIcon: animationIcon,
                delta: delta,
                settings: settings,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initAnimations() {
    animationGuillotine = Tween(begin: math.pi / 2, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.8,
          curve: settings.guillotineCurveOut,
        ),
        reverseCurve: Interval(
          0.0,
          0.8,
          curve: settings.guillotineCurveIn,
        ),
      ),
    );

    animationIcon = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: settings.iconCurve,
      ),
    );

    animationAppBarOppacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.27),
        reverseCurve: const Interval(0.6, 0.67),
      ),
    );

    animationContentOppacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.27, 0.3),
        reverseCurve: const Interval(0.7, 0.72),
      ),
    );
  }

  @override
  void initControlFlags() {
    delta = isLeftSide ? -1.0 : 1.0;
  }

  @override
  void initDragUtils(Size size) {
    // No drag gor guillotine
  }
}
