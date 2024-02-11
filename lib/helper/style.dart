import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';

const bodyText2 = TextStyle(
  fontSize: 14,
  color: black,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontFamily: "Roboto",
  package: "xefi_flutter_ui_kit",
);

const bodyTextMonserat14 = TextStyle(
  fontSize: 14,
  color: black,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontFamily: "Montserrat",
  package: "xefi_flutter_ui_kit",
);

ThemeData xMyTheme = ThemeData(
  primaryColor: Colors.red, // Couleur principale de l'application
  colorScheme: const ColorScheme(
      background: Color.fromRGBO(61, 61, 61, 1),
      brightness: Brightness.light,
      primary: Colors.red,
      onPrimary: Colors.orange,
      secondary: Colors.black26,
      onSecondary: Colors.black26,
      error: Colors.red,
      onError: Colors.redAccent,
      onBackground: Colors.green,
      //TEXT
      surface: Colors.white,
      onSurface: Colors.white),
  // Couleur d'accentuation utilisée pour les éléments interactifs
  fontFamily: 'ProtestRiot-Regular', // Police de caractères par défaut
);
