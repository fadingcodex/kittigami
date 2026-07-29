import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:kittigami/kittigami.dart';

void main() {
  test('breakpoints resolve dual and tri pane thresholds', () {
    const breakpoints = KittigamiBreakpoints(
      dualPaneMinWidth: 800,
      triPaneMinWidth: 1200,
    );

    expect(breakpoints.supportsDualPane(700), isFalse);
    expect(breakpoints.supportsDualPane(800), isTrue);
    expect(breakpoints.supportsTriPane(1199), isFalse);
    expect(breakpoints.supportsTriPane(1200), isTrue);
  });

  test('navigation model updates selected destination', () {
    final model = KittigamiNavigationModel(
      destinations: const [
        KittigamiNavigationDestination(id: 'inbox', label: 'Inbox'),
        KittigamiNavigationDestination(id: 'updates', label: 'Updates'),
      ],
    );

    expect(model.selectedId, 'inbox');
    model.select('updates');
    expect(model.selectedId, 'updates');

    model.select('missing');
    expect(model.selectedId, 'updates');
  });

  testWidgets('theme inherited data can be resolved from context', (
    tester,
  ) async {
    const probeKey = Key('theme-probe');
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: Builder(
            builder: (context) {
              final theme = KittigamiTheme.of(context);
              return Text(
                '${theme.spacing.md}',
                key: probeKey,
                style: theme.typography.body,
              );
            },
          ),
        ),
      ),
    );

    expect(find.byKey(probeKey), findsOneWidget);
  });

  testWidgets('tri pane layout shows all regions on wide constraints', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light().copyWith(
            breakpoints: const KittigamiBreakpoints(
              dualPaneMinWidth: 700,
              triPaneMinWidth: 900,
            ),
          ),
          child: SizedBox(
            width: 1200,
            child: KittigamiPaneLayout(
              navigationPane: const SizedBox(key: Key('nav-pane')),
              listPane: const SizedBox(key: Key('list-pane')),
              detailPane: const SizedBox(key: Key('detail-pane')),
              forcedBehavior: KittigamiPaneBehavior.tri,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('nav-pane')), findsOneWidget);
    expect(find.byKey(const Key('list-pane')), findsOneWidget);
    expect(find.byKey(const Key('detail-pane')), findsOneWidget);
  });

  testWidgets('text field renders label and updates controller text', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: KittigamiTextField(
            label: 'Search',
            hintText: 'Search threads',
            controller: controller,
          ),
        ),
      ),
    );

    expect(find.text('Search'), findsOneWidget);
    await tester.enterText(find.byType(EditableText), 'hello');
    expect(controller.text, 'hello');
  });

  testWidgets('checkbox toggles value on tap', (tester) async {
    bool checked = false;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: KittigamiCheckbox(
            label: 'Unread only',
            value: checked,
            onChanged: (value) {
              checked = value;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(KittigamiCheckbox));
    await tester.pump();
    expect(checked, isTrue);
  });
}
