import "package:flutter/material.dart";

import "package:chat_gpt_app/app/core/ui/styles/colors_app.dart";

class ThemeConfig {
  ThemeConfig._();

  static const OutlineInputBorder _defaultInputBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  static final ThemeData theme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionHandleColor: Colors.white
    ),
    scaffoldBackgroundColor: ColorsApp.instance.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black)
    ),
    primaryColor: ColorsApp.instance.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.primary,
      primary: ColorsApp.instance.primary,
      secondary: ColorsApp.instance.secondary
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorsApp.instance.secondary,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      border: ThemeConfig._defaultInputBorder,
      enabledBorder: ThemeConfig._defaultInputBorder,
      focusedBorder: ThemeConfig._defaultInputBorder
    )
  );
}