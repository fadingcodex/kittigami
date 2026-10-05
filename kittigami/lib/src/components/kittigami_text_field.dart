import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

class KittigamiTextField extends StatefulWidget {
  const KittigamiTextField({
    this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.minLines,
    this.maxLines,
    this.expands = false,
    super.key,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final bool expands;

  @override
  State<KittigamiTextField> createState() => _KittigamiTextFieldState();
}

class _KittigamiTextFieldState extends State<KittigamiTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final hasMultiline =
        (widget.minLines ?? 1) > 1 || (widget.maxLines ?? 1) > 1;
    final effectiveMinLines = widget.minLines ?? (hasMultiline ? 1 : 1);
    final effectiveMaxLines = widget.maxLines ?? (hasMultiline ? null : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.xs),
            child: Text(widget.label!, style: theme.typography.caption),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.surfaceMuted,
            border: Border.all(color: theme.colors.border),
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.xs,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: hasMultiline ? theme.spacing.xl : theme.spacing.lg,
              ),
              // Without an app-level WidgetsApp, backspace/delete/arrow keys
              // have no Shortcuts binding to EditableText's built-in actions.
              child: DefaultTextEditingShortcuts(
                child: EditableText(
                  controller: widget.controller ?? TextEditingController(),
                  focusNode: _focusNode,
                  style: theme.typography.body,
                  cursorColor: theme.colors.info,
                  backgroundCursorColor: theme.colors.info,
                  onChanged: widget.enabled ? widget.onChanged : null,
                  keyboardType: hasMultiline
                      ? TextInputType.multiline
                      : TextInputType.text,
                  textAlign: TextAlign.start,
                  minLines: effectiveMinLines,
                  maxLines: effectiveMaxLines,
                  expands: widget.expands,
                ),
              ),
            ),
          ),
        ),
        if (widget.hintText != null)
          Padding(
            padding: EdgeInsets.only(top: theme.spacing.xs),
            child: Text(widget.hintText!, style: theme.typography.caption),
          ),
      ],
    );
  }
}
