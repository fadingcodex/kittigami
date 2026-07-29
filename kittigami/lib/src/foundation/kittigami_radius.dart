class KittigamiRadius {
  const KittigamiRadius({this.sm = 4, this.md = 6, this.lg = 10})
    : assert(sm > 0),
      assert(md >= sm),
      assert(lg >= md);

  final double sm;
  final double md;
  final double lg;

  KittigamiRadius copyWith({double? sm, double? md, double? lg}) {
    return KittigamiRadius(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiRadius &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg;
  }

  @override
  int get hashCode => Object.hash(sm, md, lg);
}
