import 'package:flutter/cupertino.dart';

class AppContext {
  /// get the material key context so that it[the app build context] can be used any where in the app
  static GlobalKey<NavigatorState> materialKeyContext =
      GlobalKey<NavigatorState>();

  static BuildContext materialBuildContext =
      materialKeyContext.currentContext as BuildContext;

  static BuildContext get masterKey => AppContext.materialBuildContext;
}
