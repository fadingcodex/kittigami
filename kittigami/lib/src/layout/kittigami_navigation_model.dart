import 'package:flutter/foundation.dart';

import 'kittigami_navigation_destination.dart';

class KittigamiNavigationModel extends ChangeNotifier {
  KittigamiNavigationModel({
    required List<KittigamiNavigationDestination> destinations,
    String? selectedId,
  }) : assert(destinations.isNotEmpty),
       _destinations = List.unmodifiable(destinations),
       _selectedId = selectedId ?? destinations.first.id;

  final List<KittigamiNavigationDestination> _destinations;
  String _selectedId;

  List<KittigamiNavigationDestination> get destinations => _destinations;

  String get selectedId => _selectedId;

  void select(String id) {
    if (_selectedId == id) return;
    final exists = _destinations.any((destination) => destination.id == id);
    if (!exists) return;
    _selectedId = id;
    notifyListeners();
  }
}
