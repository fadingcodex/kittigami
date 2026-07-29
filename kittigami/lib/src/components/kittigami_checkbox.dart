import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

class KittigamiCheckbox extends StatelessWidget {
  const KittigamiCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.surfaceMuted,
          border: Border.all(color: theme.colors.border),
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
              SizedBox(
                width: theme.spacing.lg,
                height: theme.spacing.lg,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: value ? theme.colors.info : theme.colors.surface,
                    border: Border.all(color: theme.colors.border),
                    borderRadius: BorderRadius.circular(theme.radius.sm),
                  ),
                  child: Center(
                    child: Text(
                      value ? '✓' : '',
                      style: theme.typography.listText.copyWith(
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: theme.spacing.sm),
              Text(label, style: theme.typography.body),
            ],
          ),
        ),
      ),
    );
  }
}
