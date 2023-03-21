import "package:flutter/material.dart";

class TextStyles {
  static TextStyles? _instance;
  static const String openSans = "OpenSans";
  static const String lato = "Lato";

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get font => TextStyles.openSans;

  TextStyle get textLight => TextStyle(fontWeight: FontWeight.w300, fontFamily: this.font, color: Colors.white);

  TextStyle get textRegular => TextStyle(fontWeight: FontWeight.normal, fontFamily: this.font, color: Colors.white);

  TextStyle get textMedium => TextStyle(fontWeight: FontWeight.w500, fontFamily: this.font, color: Colors.white);

  TextStyle get textSemiBold => TextStyle(fontWeight: FontWeight.w600, fontFamily: this.font, color: Colors.white);

  TextStyle get textBold => TextStyle(fontWeight: FontWeight.bold, fontFamily: this.font, color: Colors.white);

  TextStyle get textExtraBold => TextStyle(fontWeight: FontWeight.w800, fontFamily: this.font, color: Colors.white);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}