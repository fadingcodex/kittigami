import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';
import '../foundation/kittigami_theme_data.dart';

enum KittigamiPaneBehavior { single, dual, tri }

class KittigamiPaneLayout extends StatelessWidget {
  const KittigamiPaneLayout({
    required this.navigationPane,
    required this.listPane,
    this.detailPane,
    this.forcedBehavior,
    this.navigationWidth = 232,
    this.listFlex = 2,
    this.detailFlex = 3,
    super.key,
  }) : assert(navigationWidth > 0),
       assert(listFlex > 0),
       assert(detailFlex > 0);

  final Widget navigationPane;
  final Widget listPane;
  final Widget? detailPane;
  final KittigamiPaneBehavior? forcedBehavior;
  final double navigationWidth;
  final int listFlex;
  final int detailFlex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = KittigamiTheme.of(context);
        final behavior =
            forcedBehavior ?? _resolveBehavior(theme, constraints.maxWidth);

        final divider = _PaneDivider(color: theme.colors.divider);

        switch (behavior) {
          case KittigamiPaneBehavior.single:
            return detailPane ?? listPane;
          case KittigamiPaneBehavior.dual:
            return Row(
              children: [
                SizedBox(width: navigationWidth, child: navigationPane),
                divider,
                Expanded(child: detailPane ?? listPane),
              ],
            );
          case KittigamiPaneBehavior.tri:
            return Row(
              children: [
                SizedBox(width: navigationWidth, child: navigationPane),
                divider,
                Expanded(flex: listFlex, child: listPane),
                divider,
                Expanded(flex: detailFlex, child: detailPane ?? listPane),
              ],
            );
        }
      },
    );
  }

  KittigamiPaneBehavior _resolveBehavior(
    KittigamiThemeData theme,
    double width,
  ) {
    if (theme.breakpoints.supportsTriPane(width) && detailPane != null) {
      return KittigamiPaneBehavior.tri;
    }
    if (theme.breakpoints.supportsDualPane(width)) {
      return KittigamiPaneBehavior.dual;
    }
    return KittigamiPaneBehavior.single;
  }
}

class _PaneDivider extends StatelessWidget {
  const _PaneDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 1, child: ColoredBox(color: color));
  }
}
