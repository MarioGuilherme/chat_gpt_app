import "package:flutter/material.dart";

extension SizeExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => this.screenWidth * percent;
  double percentHeigth(double percent) => this.screenHeight * percent;
}