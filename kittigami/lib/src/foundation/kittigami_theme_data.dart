import 'kittigami_breakpoints.dart';
import 'kittigami_colors.dart';
import 'kittigami_radius.dart';
import 'kittigami_spacing.dart';
import 'kittigami_typography.dart';

class KittigamiThemeData {
  const KittigamiThemeData({
    required this.colors,
    required this.typography,
    this.spacing = const KittigamiSpacing(),
    this.radius = const KittigamiRadius(),
    this.breakpoints = const KittigamiBreakpoints(),
    this.highDensity = true,
  });

  factory KittigamiThemeData.light() {
    const colors = KittigamiColors.light();
    return KittigamiThemeData(
      colors: colors,
      typography: KittigamiTypography.compact(
        textColor: colors.textPrimary,
        secondaryColor: colors.textSecondary,
      ),
    );
  }

  final KittigamiColors colors;
  final KittigamiTypography typography;
  final KittigamiSpacing spacing;
  final KittigamiRadius radius;
  final KittigamiBreakpoints breakpoints;
  final bool highDensity;

  KittigamiThemeData copyWith({
    KittigamiColors? colors,
    KittigamiTypography? typography,
    KittigamiSpacing? spacing,
    KittigamiRadius? radius,
    KittigamiBreakpoints? breakpoints,
    bool? highDensity,
  }) {
    return KittigamiThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      breakpoints: breakpoints ?? this.breakpoints,
      highDensity: highDensity ?? this.highDensity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiThemeData &&
        other.colors == colors &&
        other.typography == typography &&
        other.spacing == spacing &&
        other.radius == radius &&
        other.breakpoints == breakpoints &&
        other.highDensity == highDensity;
  }

  @override
  int get hashCode => Object.hash(
    colors,
    typography,
    spacing,
    radius,
    breakpoints,
    highDensity,
  );
}
