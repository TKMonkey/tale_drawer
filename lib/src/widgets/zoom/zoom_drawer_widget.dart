part of '../tale_widget.dart';

class ZoomDrawerWidget extends TaleDrawerState {
  double value = 0.0;

  late double addSizeForRightSide;

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
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.blue,
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.star,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: value,
                  max: animationController.upperBound,
                  onChanged: (v) {
                    setState(() {
                      value = v;
                      animationController.value = v;
                    });
                  },
                ),
                Text('Value ${value.toStringAsFixed(2)}')
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initAnimations() {}

  @override
  void initControllFlags() {
    animationController.value = !isStartedOpen ? 0.0 : 1.0;
    delta = isLeftSide ? -1.0 : 1.0;
    addSizeForRightSide = isLeftSide ? 1.0 : 0.0;
  }

  @override
  ZoomSettings get settings =>
      (widget.settings ?? const ZoomSettings()) as ZoomSettings;

  double slideSize(double width) => settings.maxSlide + addRotationSlide(width);

  double addRotationSlide(double width) =>
      width * settings.rotation.abs() / 100;
}
