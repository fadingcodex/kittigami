import 'package:flutter/painting.dart';

class KittigamiTypography {
  const KittigamiTypography({
    required this.navigationLabel,
    required this.listText,
    required this.paneTitle,
    required this.body,
    required this.caption,
  });

  factory KittigamiTypography.compact({
    String fontFamily = 'Noto Sans',
    Color textColor = const Color(0xFF1E252B),
    Color secondaryColor = const Color(0xFF4E5A66),
  }) {
    return KittigamiTypography(
      navigationLabel: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: secondaryColor,
      ),
      listText: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.25,
        color: textColor,
      ),
      paneTitle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: textColor,
      ),
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: textColor,
      ),
      caption: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.3,
        color: secondaryColor,
      ),
    );
  }

  final TextStyle navigationLabel;
  final TextStyle listText;
  final TextStyle paneTitle;
  final TextStyle body;
  final TextStyle caption;

  KittigamiTypography copyWith({
    TextStyle? navigationLabel,
    TextStyle? listText,
    TextStyle? paneTitle,
    TextStyle? body,
    TextStyle? caption,
  }) {
    return KittigamiTypography(
      navigationLabel: navigationLabel ?? this.navigationLabel,
      listText: listText ?? this.listText,
      paneTitle: paneTitle ?? this.paneTitle,
      body: body ?? this.body,
      caption: caption ?? this.caption,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KittigamiTypography &&
        other.navigationLabel == navigationLabel &&
        other.listText == listText &&
        other.paneTitle == paneTitle &&
        other.body == body &&
        other.caption == caption;
  }

  @override
  int get hashCode =>
      Object.hash(navigationLabel, listText, paneTitle, body, caption);
}
