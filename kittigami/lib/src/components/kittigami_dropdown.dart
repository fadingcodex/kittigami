import 'package:flutter/widgets.dart';

import '../foundation/kittigami_theme.dart';

class KittigamiDropdownItem<T> {
  const KittigamiDropdownItem({
    required this.value,
    required this.label,
    this.leading,
  });

  final T value;
  final String label;
  final Widget? leading;
}

class KittigamiDropdown<T> extends StatefulWidget {
  const KittigamiDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.hintText,
    this.enabled = true,
    super.key,
  });

  final String? label;
  final String? hintText;
  final List<KittigamiDropdownItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;
  final bool enabled;

  @override
  State<KittigamiDropdown<T>> createState() => _KittigamiDropdownState<T>();
}

class _KittigamiDropdownState<T> extends State<KittigamiDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _closeMenu();
    super.dispose();
  }

  KittigamiDropdownItem<T>? get _selectedItem {
    for (final item in widget.items) {
      if (item.value == widget.value) {
        return item;
      }
    }
    return widget.items.isNotEmpty ? widget.items.first : null;
  }

  void _toggleMenu() {
    if (!widget.enabled) {
      return;
    }
    if (_overlayEntry != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = KittigamiTheme.of(context);
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeMenu,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                theme.spacing.compactRowHeight + theme.spacing.xs,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 220),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    border: Border.all(color: theme.colors.border),
                    borderRadius: BorderRadius.circular(theme.radius.sm),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: theme.colors.divider),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final selected = item.value == widget.value;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.onChanged(item.value);
                          _closeMenu();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: selected ? theme.colors.selection : null,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.md,
                              vertical: theme.spacing.sm,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (item.leading != null) ...[
                                  item.leading!,
                                  SizedBox(width: theme.spacing.sm),
                                ],
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: theme.typography.listText,
                                  ),
                                ),
                                if (selected)
                                  Text(
                                    '✓',
                                    style: theme.typography.listText.copyWith(
                                      color: theme.colors.info,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() {});
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = KittigamiTheme.of(context);
    final selectedItem = _selectedItem;
    final selectedLeading = selectedItem?.leading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.xs),
            child: Text(widget.label!, style: theme.typography.caption),
          ),
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleMenu,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.enabled
                    ? theme.colors.surfaceMuted
                    : theme.colors.surface,
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
                    if (selectedLeading != null) ...[
                      selectedLeading,
                      SizedBox(width: theme.spacing.sm),
                    ],
                    Text(
                      selectedItem?.label ?? '',
                      style: theme.typography.listText,
                    ),
                    SizedBox(width: theme.spacing.sm),
                    Text('v', style: theme.typography.caption),
                  ],
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
