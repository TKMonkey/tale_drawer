part of '../tale_widget.dart';

class GuillotineDrawerWidget extends TaleDrawerState {
  @override
  Widget build(BuildContext context) {
    print('Guillotine');
    return Container(
      child: Center(
        child: Text('Hello'),
      ),
    );
  }

  @override
  void initAnimations() {}

  @override
  void initControllFlags() {
    // TODO: implement initControllFlags
  }

  // @override
  // TaleSettings get settings => widget.settings ?? const GuillotineSettings();
}
