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

  testWidgets('data table renders its empty message', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: KittigamiDataTable(
            columns: const [KittigamiDataColumn(id: 'name', label: 'Name')],
            rows: const [],
            emptyMessage: 'Nothing here yet.',
          ),
        ),
      ),
    );

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Nothing here yet.'), findsOneWidget);
  });

  testWidgets('data table reports sort and selection interactions', (
    tester,
  ) async {
    var sortCount = 0;
    bool? selected;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: KittigamiDataTable(
            columns: [
              KittigamiDataColumn(
                id: 'name',
                label: 'Name',
                onSort: () => sortCount++,
              ),
            ],
            rows: [
              KittigamiDataRow(
                id: 'ada',
                selected: true,
                onSelected: (value) => selected = value,
                cells: const [Text('Ada')],
              ),
            ],
            sortColumnId: 'name',
            sortDirection: KittigamiSortDirection.ascending,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Name'));
    await tester.pump();
    expect(sortCount, 1);

    await tester.tap(find.text('Ada'));
    await tester.pump();
    expect(selected, isFalse);

    final table = tester.widget<Table>(find.byType(Table));
    final selectedRow = table.children[1];
    final decoration = selectedRow.decoration! as BoxDecoration;
    expect(decoration.color, KittigamiThemeData.light().colors.selection);
  });

  testWidgets('data table scrolls horizontally within narrow constraints', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: KittigamiTheme(
          data: KittigamiThemeData.light(),
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 120,
              child: KittigamiDataTable(
                columns: const [
                  KittigamiDataColumn(id: 'name', label: 'Name'),
                  KittigamiDataColumn(id: 'status', label: 'Status'),
                ],
                rows: const [
                  KittigamiDataRow(
                    id: 'ada',
                    cells: [Text('Ada'), Text('Active')],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final scrollable = tester.state<ScrollableState>(find.byType(Scrollable));
    expect(tester.getSize(find.byType(SingleChildScrollView)).width, 120);
    expect(scrollable.position.maxScrollExtent, greaterThan(0));
    scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
    await tester.pump();

    expect(scrollable.position.pixels, greaterThan(0));
    expect(tester.takeException(), isNull);
  });

  testWidgets('dropdown opens and selects an item', (tester) async {
    String selected = 'follow_up';

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => KittigamiTheme(
                data: KittigamiThemeData.light(),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return KittigamiDropdown<String>(
                      label: 'Reply mode',
                      value: selected,
                      onChanged: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                      items: const [
                        KittigamiDropdownItem(
                          value: 'follow_up',
                          label: 'Follow up',
                        ),
                        KittigamiDropdownItem(
                          value: 'review',
                          label: 'Review later',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Follow up'), findsOneWidget);
    await tester.tap(find.text('Follow up'));
    await tester.pumpAndSettle();

    expect(find.text('Review later'), findsWidgets);
    await tester.tap(find.text('Review later').last);
    await tester.pumpAndSettle();

    expect(selected, 'review');
    expect(find.text('Review later'), findsOneWidget);
  });
}
