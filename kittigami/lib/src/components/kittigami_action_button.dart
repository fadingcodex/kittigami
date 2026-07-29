import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';
import '../foundation/kittigami_theme_data.dart';

enum KittigamiActionButtonKind { primary, secondary, danger }

class KittigamiActionButton extends StatelessWidget {
  const KittigamiActionButton({
    required this.label,
    required this.onPressed,
    this.kind = KittigamiActionButtonKind.primary,
    this.leading,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final KittigamiActionButtonKind kind;
  final Widget? leading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final colors = _resolveColors(theme);

    return Semantics(
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.background,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: theme.spacing.xs),
                ],
                Text(
                  label,
                  style: theme.typography.listText.copyWith(color: colors.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ButtonColors _resolveColors(KittigamiThemeData theme) {
    if (!enabled) {
      return _ButtonColors(
        background: theme.colors.surfaceMuted,
        border: theme.colors.border,
        text: theme.colors.textSecondary,
      );
    }

    switch (kind) {
      case KittigamiActionButtonKind.primary:
        return _ButtonColors(
          background: theme.colors.info,
          border: theme.colors.info,
          text: const Color(0xFFFFFFFF),
        );
      case KittigamiActionButtonKind.secondary:
        return _ButtonColors(
          background: theme.colors.surfaceMuted,
          border: theme.colors.border,
          text: theme.colors.textPrimary,
        );
      case KittigamiActionButtonKind.danger:
        return _ButtonColors(
          background: theme.colors.error,
          border: theme.colors.error,
          text: const Color(0xFFFFFFFF),
        );
    }
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.border,
    required this.text,
  });

  final Color background;
  final Color border;
  final Color text;
}
