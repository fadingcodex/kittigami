import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

class KittigamiCommandBar extends StatelessWidget {
  const KittigamiCommandBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surfaceMuted,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.sm),
        child: Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: children,
        ),
      ),
    );
  }
}
