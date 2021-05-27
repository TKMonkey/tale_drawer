part of '../tale_widget.dart';

class FlipDrawerWidget extends TaleDrawerState {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello'),
      ),
    );
  }

  @override
  void initAnimations() {
    // TODO: implement initAnimations
  }

  @override
  void initControllFlags() {
    // TODO: implement initControllFlags
  }

  @override
  FlipSettings get settings =>
      (widget.settings ?? const FlipSettings()) as FlipSettings;
}
