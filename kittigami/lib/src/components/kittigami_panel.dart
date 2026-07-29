import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

class KittigamiPanel extends StatelessWidget {
  const KittigamiPanel({
    required this.child,
    this.padding,
    this.background,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background ?? theme.colors.surface,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(theme.spacing.md),
        child: child,
      ),
    );
  }
}
