import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';
import '../foundation/kittigami_theme_data.dart';

enum KittigamiBannerTone { info, success, warning, error }

class KittigamiBanner extends StatelessWidget {
  const KittigamiBanner({
    required this.message,
    this.title,
    this.tone = KittigamiBannerTone.info,
    this.trailing,
    super.key,
  });

  final String message;
  final String? title;
  final KittigamiBannerTone tone;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final accent = _accent(theme);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surfaceMuted,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(theme.radius.sm),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(theme.radius.sm),
        child: Row(
          children: [
            SizedBox(width: 3, child: ColoredBox(color: accent)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(title!, style: theme.typography.listText),
                          if (title != null) SizedBox(height: theme.spacing.xs),
                          Text(message, style: theme.typography.caption),
                        ],
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: theme.spacing.sm),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _accent(KittigamiThemeData theme) {
    switch (tone) {
      case KittigamiBannerTone.info:
        return theme.colors.info;
      case KittigamiBannerTone.success:
        return theme.colors.success;
      case KittigamiBannerTone.warning:
        return theme.colors.warning;
      case KittigamiBannerTone.error:
        return theme.colors.error;
    }
  }
}
