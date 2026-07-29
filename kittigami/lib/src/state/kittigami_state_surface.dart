import 'package:flutter/widgets.dart';

import '../components/kittigami_action_button.dart';
import '../foundation/kittigami_theme.dart';

enum KittigamiViewState { loading, empty, error, success, content }

class KittigamiStateSurface extends StatelessWidget {
  const KittigamiStateSurface({
    required this.state,
    this.child,
    this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  }) : assert(
         actionLabel == null || onAction != null,
         'onAction is required when actionLabel is provided.',
       );

  final KittigamiViewState state;
  final Widget? child;
  final String? title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    if (state == KittigamiViewState.content) {
      return child ?? const SizedBox.shrink();
    }

    final theme = KittigamiTheme.of(context);
    final headline = title ?? _defaultTitle;
    final detail = message ?? _defaultMessage;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(headline, style: theme.typography.paneTitle),
                SizedBox(height: theme.spacing.sm),
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: theme.typography.body,
                ),
                if (actionLabel != null) ...[
                  SizedBox(height: theme.spacing.lg),
                  KittigamiActionButton(
                    label: actionLabel!,
                    onPressed: onAction!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _defaultTitle {
    switch (state) {
      case KittigamiViewState.loading:
        return 'Loading';
      case KittigamiViewState.empty:
        return 'Nothing here yet';
      case KittigamiViewState.error:
        return 'Something went wrong';
      case KittigamiViewState.success:
        return 'Done';
      case KittigamiViewState.content:
        return '';
    }
  }

  String get _defaultMessage {
    switch (state) {
      case KittigamiViewState.loading:
        return 'Please wait while content is prepared.';
      case KittigamiViewState.empty:
        return 'There is no content to display in this section.';
      case KittigamiViewState.error:
        return 'Try again or choose another section.';
      case KittigamiViewState.success:
        return 'The operation completed successfully.';
      case KittigamiViewState.content:
        return '';
    }
  }
}
