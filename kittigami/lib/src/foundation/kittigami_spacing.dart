class KittigamiSpacing {
  const KittigamiSpacing({
    this.xs = 4,
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 24,
    this.compactRowHeight = 32,
  }) : assert(xs > 0),
       assert(sm > xs),
       assert(md > sm),
       assert(lg > md),
       assert(xl > lg),
       assert(compactRowHeight >= 28);

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double compactRowHeight;

  KittigamiSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? compactRowHeight,
  }) {
    return KittigamiSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      compactRowHeight: compactRowHeight ?? this.compactRowHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiSpacing &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.compactRowHeight == compactRowHeight;
  }

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, compactRowHeight);
}
