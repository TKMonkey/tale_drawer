import 'package:tale_drawer/src/config/tale_type.dart';
import 'package:tale_drawer/src/widgets/tale_drawer_state.dart';

/// {@template tale_settings}
///
/// Base class for tale settings
/// With this the library identity the setting for `Flip`, `Guillotine` and `Zoom`
///
/// {@endtemplate}
abstract class TaleSettings {
  Duration get duration;

  TaleType get type;

  TaleDrawerState createState();
}
