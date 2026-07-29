import 'package:flutter/widgets.dart';

import 'kittigami_theme_data.dart';

class KittigamiTheme extends InheritedWidget {
  const KittigamiTheme({required this.data, required super.child, super.key});

  final KittigamiThemeData data;

  static KittigamiThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<KittigamiTheme>();
    return theme?.data ?? KittigamiThemeData.light();
  }

  @override
  bool updateShouldNotify(KittigamiTheme oldWidget) => data != oldWidget.data;
}
