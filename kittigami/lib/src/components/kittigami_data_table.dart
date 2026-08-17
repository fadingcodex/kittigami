import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

enum KittigamiSortDirection { ascending, descending }

class KittigamiDataColumn {
  const KittigamiDataColumn({
    required this.id,
    required this.label,
    this.width,
    this.alignment = Alignment.centerLeft,
    this.onSort,
  }) : assert(id != ''),
       assert(width == null || width > 0);

  final String id;
  final String label;
  final double? width;
  final AlignmentGeometry alignment;
  final VoidCallback? onSort;
}

class KittigamiDataRow {
  const KittigamiDataRow({
    required this.id,
    required this.cells,
    this.selected = false,
    this.onSelected,
  }) : assert(id != '');

  final String id;
  final List<Widget> cells;
  final bool selected;
  final ValueChanged<bool>? onSelected;
}

class KittigamiDataTable extends StatelessWidget {
  KittigamiDataTable({
    required this.columns,
    required this.rows,
    this.sortColumnId,
    this.sortDirection,
    this.emptyMessage = 'No items to display.',
    super.key,
  }) : assert(columns.isNotEmpty),
       assert(
         columns.map((column) => column.id).toSet().length == columns.length,
       ),
       assert(rows.map((row) => row.id).toSet().length == rows.length),
       assert(
         rows.every((row) => row.cells.length == columns.length),
         'Each row must provide one cell for every column.',
       );

  final List<KittigamiDataColumn> columns;
  final List<KittigamiDataRow> rows;
  final String? sortColumnId;
  final KittigamiSortDirection? sortDirection;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final tableWidth = columns.fold<double>(
      0,
      (width, column) => width + (column.width ?? 160),
    );
    final columnWidths = <int, TableColumnWidth>{
      for (var index = 0; index < columns.length; index++)
        index: FixedColumnWidth(columns[index].width ?? 160),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(theme.radius.md),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.hasBoundedWidth ? constraints.maxWidth : null,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Table(
                    columnWidths: columnWidths,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder(
                      horizontalInside: BorderSide(color: theme.colors.divider),
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: theme.colors.surfaceMuted,
                        ),
                        children: [
                          for (final column in columns)
                            _KittigamiDataTableHeaderCell(
                              column: column,
                              isSorted: sortColumnId == column.id,
                              sortDirection: sortDirection,
                            ),
                        ],
                      ),
                      if (rows.isEmpty)
                        TableRow(
                          children: [
                            _KittigamiDataTableCell(
                              alignment: columns.first.alignment,
                              child: Text(
                                emptyMessage,
                                style: theme.typography.body.copyWith(
                                  color: theme.colors.textSecondary,
                                ),
                              ),
                            ),
                            for (var index = 1; index < columns.length; index++)
                              const SizedBox.shrink(),
                          ],
                        )
                      else
                        for (final row in rows)
                          TableRow(
                            decoration: BoxDecoration(
                              color: row.selected
                                  ? theme.colors.selection
                                  : null,
                            ),
                            children: [
                              for (
                                var index = 0;
                                index < columns.length;
                                index++
                              )
                                _KittigamiDataTableRowCell(
                                  alignment: columns[index].alignment,
                                  onSelected: row.onSelected == null
                                      ? null
                                      : () => row.onSelected!(!row.selected),
                                  child: row.cells[index],
                                ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _KittigamiDataTableHeaderCell extends StatelessWidget {
  const _KittigamiDataTableHeaderCell({
    required this.column,
    required this.isSorted,
    required this.sortDirection,
  });

  final KittigamiDataColumn column;
  final bool isSorted;
  final KittigamiSortDirection? sortDirection;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final directionLabel = switch (sortDirection) {
      KittigamiSortDirection.ascending => 'ascending',
      KittigamiSortDirection.descending => 'descending',
      null => null,
    };
    final label = isSorted
        ? '${column.label}, sorted $directionLabel'
        : column.label;

    final content = SizedBox(
      height: theme.spacing.compactRowHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
        child: Align(
          alignment: column.alignment,
          child: Text(column.label, style: theme.typography.listText),
        ),
      ),
    );

    if (column.onSort == null) {
      return Semantics(header: true, label: label, child: content);
    }

    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(onTap: column.onSort, child: content),
    );
  }
}

class _KittigamiDataTableRowCell extends StatelessWidget {
  const _KittigamiDataTableRowCell({
    required this.alignment,
    required this.child,
    required this.onSelected,
  });

  final AlignmentGeometry alignment;
  final Widget child;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final content = _KittigamiDataTableCell(alignment: alignment, child: child);

    if (onSelected == null) {
      return content;
    }

    return Semantics(
      button: true,
      child: GestureDetector(onTap: onSelected, child: content),
    );
  }
}

class _KittigamiDataTableCell extends StatelessWidget {
  const _KittigamiDataTableCell({required this.alignment, required this.child});

  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: theme.spacing.compactRowHeight),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.xs,
        ),
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}
