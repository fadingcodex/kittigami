import 'package:flutter/widgets.dart';

class KittigamiNavigationDestination {
  const KittigamiNavigationDestination({
    required this.id,
    required this.label,
    this.leading,
  });

  final String id;
  final String label;
  final Widget? leading;
}
