import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';

const bodyText2 = TextStyle(
  fontSize: 14,
  color: black,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

const titleText1 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
);

const antaStyle = TextStyle(color: Colors.white, fontSize: 12);

const titleStyle = TextStyle(
  fontSize: 24,
);

const styleWidget = TextStyle(
  fontSize: 15,
  color: grey15,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  overflow: TextOverflow.ellipsis,
);

ThemeData xMyTheme = ThemeData(
  primaryColor: Colors.red, // Couleur principale de l'application
  colorScheme: const ColorScheme(
    background: Color.fromRGBO(32, 32, 32, 1),
    brightness: Brightness.light,
    primary: Colors.red,
    onPrimary: Colors.orange,
    secondary: Color(0x42000000),
    onSecondary: Colors.black26,
    error: Colors.red,
    onError: Colors.redAccent,
    onBackground: Colors.green,
    //TEXT
    surface: Colors.white,
    onSurface: Colors.white,
    surfaceTint: Colors.black,
    surfaceVariant: Colors.black,
  ),
  dialogBackgroundColor: Colors.black,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black54),
  // Couleur d'accentuation utilisée pour les éléments interactifs
  fontFamily: 'Anta', // Police de caractères par défaut
);

InputDecoration textFormDecoration({
  String hintText = '',
  TextStyle? hintStyle,
  bool? isPassword,
  bool hidePassword = false,
  Function? onVisibilityIconPressed,
  required Color fillColor,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? helperText,
  TextStyle? helperStyle,
  bool enabled = true,
  EdgeInsetsGeometry? contentPadding,
  bool? isCollapsed,
  double? borderRadius = 10,
  TextStyle? errorStyle,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: hintStyle ?? xMyTheme.textTheme.bodyMedium,
    helperText: helperText,
    helperStyle: helperStyle ?? xMyTheme.textTheme.bodySmall,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    errorStyle: errorStyle,
    filled: true,
    border: InputBorder.none,
    fillColor: fillColor,
    enabled: enabled,
    contentPadding: contentPadding,
    isCollapsed: isCollapsed ?? false,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 10,
        ),
      ),
      borderSide: const BorderSide(
        color: inputActive,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 10,
        ),
      ),
      borderSide: const BorderSide(
        color: inputActive,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 10,
        ),
      ),
      borderSide: const BorderSide(
        color: inputError,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 10,
        ),
      ),
      borderSide: const BorderSide(
        color: inputDisabled,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 10,
        ),
      ),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    prefixIcon: prefixIcon,
    suffixIcon: (isPassword == true)
        ? IconButton(
            icon: Icon(
              hidePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: black,
            ),
            onPressed: () => onVisibilityIconPressed != null
                ? onVisibilityIconPressed()
                : null,
          )
        : suffixIcon,
  );
}
