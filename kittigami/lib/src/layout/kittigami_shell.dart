import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';
import 'kittigami_navigation_model.dart';
import 'kittigami_pane_layout.dart';

typedef KittigamiPaneBuilder =
    Widget Function(BuildContext context, String selectedId);

class KittigamiShell extends StatelessWidget {
  const KittigamiShell({
    required this.navigation,
    required this.listPaneBuilder,
    this.detailPaneBuilder,
    this.title,
    this.paneBehavior,
    this.headerTrailing,
    super.key,
  });

  final KittigamiNavigationModel navigation;
  final KittigamiPaneBuilder listPaneBuilder;
  final KittigamiPaneBuilder? detailPaneBuilder;
  final String? title;
  final KittigamiPaneBehavior? paneBehavior;
  final Widget? headerTrailing;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: navigation,
      builder: (context, _) {
        final selectedId = navigation.selectedId;
        final listPane = listPaneBuilder(context, selectedId);
        final detailPane = detailPaneBuilder?.call(context, selectedId);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: KittigamiTheme.of(context).colors.surface,
          ),
          child: SafeArea(
            child: Column(
              children: [
                if (title != null)
                  _ShellHeader(title: title!, trailing: headerTrailing),
                Expanded(
                  child: KittigamiPaneLayout(
                    navigationPane: _ShellNavigation(navigation: navigation),
                    listPane: listPane,
                    detailPane: detailPane,
                    forcedBehavior: paneBehavior,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ShellHeader extends StatelessWidget {
  const _ShellHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surfaceMuted,
        border: Border(bottom: BorderSide(color: theme.colors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: theme.typography.paneTitle),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: theme.spacing.md),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class _ShellNavigation extends StatelessWidget {
  const _ShellNavigation({required this.navigation});

  final KittigamiNavigationModel navigation;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surfaceMuted,
        border: Border(right: BorderSide(color: theme.colors.border)),
      ),
      child: ListView.builder(
        itemCount: navigation.destinations.length,
        itemBuilder: (context, index) {
          final destination = navigation.destinations[index];
          final selected = destination.id == navigation.selectedId;
          return _NavigationRow(
            label: destination.label,
            leading: destination.leading,
            selected: selected,
            onTap: () => navigation.select(destination.id),
          );
        },
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({
    required this.label,
    required this.selected,
    required this.onTap,
    this.leading,
  });

  final String label;
  final Widget? leading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? theme.colors.selection : null,
            border: Border(bottom: BorderSide(color: theme.colors.divider)),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: theme.spacing.compactRowHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md,
                vertical: theme.spacing.xs,
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: theme.spacing.sm),
                  ],
                  Expanded(
                    child: Text(label, style: theme.typography.listText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
