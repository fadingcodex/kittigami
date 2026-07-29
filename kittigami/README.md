# kittigami

`kittigami` is a desktop-first Flutter UI foundation inspired by KDE interface
patterns. It focuses on density, clarity, and actionable states, with a custom
API that does not depend on `material.dart` or `cupertino.dart`.

## V1 scope

- Design tokens: colors, typography, spacing, radius, breakpoints.
- Theme runtime: `KittigamiTheme` + `KittigamiThemeData`.
- Layout primitives: shell and pane layout for desktop-style multi-panel UIs.
- State surfaces: loading, empty, error, success, content containers.

## Non-goals in V1

- Full component catalog.
- Material/Cupertino compatibility adapters.
- Mobile-first navigation patterns.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'package:kittigami/kittigami.dart';

Widget buildApp() {
	final navigation = KittigamiNavigationModel(
		destinations: const [
			KittigamiNavigationDestination(id: 'feed', label: 'Feed'),
			KittigamiNavigationDestination(id: 'saved', label: 'Saved'),
		],
	);

	return Directionality(
		textDirection: TextDirection.ltr,
		child: KittigamiTheme(
			data: KittigamiThemeData.light(),
			child: KittigamiShell(
				title: 'Community',
				navigation: navigation,
				listPaneBuilder: (context, selectedId) => Text('List: $selectedId'),
				detailPaneBuilder: (context, selectedId) => Text('Detail: $selectedId'),
			),
		),
	);
}
```
