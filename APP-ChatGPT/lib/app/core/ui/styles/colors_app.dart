import "package:flutter/material.dart";

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    ColorsApp._instance ??= ColorsApp._();
    return ColorsApp._instance!;
  }

  Color get primary => const Color.fromRGBO(51, 53, 65, 1);
  Color get secondary => const Color.fromRGBO(68, 70, 83, 1);
  Color get tertiary => const Color.fromRGBO(250, 230, 158, 1);
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}