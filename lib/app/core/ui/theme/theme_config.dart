import "package:flutter/material.dart";

import "package:chat_gpt/app/core/ui/styles/colors_app.dart";
import "package:chat_gpt/app/core/ui/styles/text_styles.dart";

class ThemeConfig {
  ThemeConfig._();

  static final OutlineInputBorder _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.grey[400]!)
  );

  static final ThemeData theme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionHandleColor: Colors.white
    ),
    scaffoldBackgroundColor: Colors.white,
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
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      border: ThemeConfig._defaultInputBorder,
      enabledBorder: ThemeConfig._defaultInputBorder,
      focusedBorder: ThemeConfig._defaultInputBorder,
      labelStyle: TextStyles.instance.textRegular.copyWith(color: Colors.black),
      errorStyle: TextStyles.instance.textRegular.copyWith(color: Colors.redAccent)
    )
  );
}