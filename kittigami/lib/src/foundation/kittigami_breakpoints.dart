class KittigamiBreakpoints {
  const KittigamiBreakpoints({
    this.dualPaneMinWidth = 900,
    this.triPaneMinWidth = 1280,
  }) : assert(dualPaneMinWidth > 0),
       assert(triPaneMinWidth >= dualPaneMinWidth);

  final double dualPaneMinWidth;
  final double triPaneMinWidth;

  bool supportsDualPane(double width) => width >= dualPaneMinWidth;

  bool supportsTriPane(double width) => width >= triPaneMinWidth;

  KittigamiBreakpoints copyWith({
    double? dualPaneMinWidth,
    double? triPaneMinWidth,
  }) {
    return KittigamiBreakpoints(
      dualPaneMinWidth: dualPaneMinWidth ?? this.dualPaneMinWidth,
      triPaneMinWidth: triPaneMinWidth ?? this.triPaneMinWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiBreakpoints &&
        other.dualPaneMinWidth == dualPaneMinWidth &&
        other.triPaneMinWidth == triPaneMinWidth;
  }

  @override
  int get hashCode => Object.hash(dualPaneMinWidth, triPaneMinWidth);
}
