import 'package:flutter/painting.dart';

class KittigamiColors {
  const KittigamiColors({
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.selection,
    required this.info,
    required this.warning,
    required this.error,
    required this.success,
  });

  const KittigamiColors.light()
    : surface = const Color(0xFFF9FAFB),
      surfaceMuted = const Color(0xFFF1F3F5),
      border = const Color(0xFFD3D9DF),
      divider = const Color(0xFFE1E6EB),
      textPrimary = const Color(0xFF1E252B),
      textSecondary = const Color(0xFF4E5A66),
      selection = const Color(0xFFD7E9FF),
      info = const Color(0xFF1D65B8),
      warning = const Color(0xFFC67B22),
      error = const Color(0xFFB33636),
      success = const Color(0xFF257942);

  final Color surface;
  final Color surfaceMuted;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color selection;
  final Color info;
  final Color warning;
  final Color error;
  final Color success;

  KittigamiColors copyWith({
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? selection,
    Color? info,
    Color? warning,
    Color? error,
    Color? success,
  }) {
    return KittigamiColors(
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      selection: selection ?? this.selection,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiColors &&
        other.surface == surface &&
        other.surfaceMuted == surfaceMuted &&
        other.border == border &&
        other.divider == divider &&
        other.textPrimary == textPrimary &&
        other.textSecondary == textSecondary &&
        other.selection == selection &&
        other.info == info &&
        other.warning == warning &&
        other.error == error &&
        other.success == success;
  }

  @override
  int get hashCode => Object.hash(
    surface,
    surfaceMuted,
    border,
    divider,
    textPrimary,
    textSecondary,
    selection,
    info,
    warning,
    error,
    success,
  );
}
