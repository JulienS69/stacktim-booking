import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';

// ignore: must_be_immutable
class XInputTextField extends StatefulWidget {
  /// controller du champ
  final TextEditingController? controller;

  /// Input formatter
  final List<TextInputFormatter>? inputFormatter;

  /// style du text
  final TextStyle? style;

  /// validation du champ
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;

  /// fonction lors d'un changement de valeur du champ
  final Function(String)? onChanged;

  /// Trigger lors du save du formulaire
  final Function(String?)? onSaved;

  /// icon après le text dans le champ
  final Widget? suffixIcon;

  /// Icon avant le text dans le champ
  final Widget? prefixIcon;

  /// boolean pour savoir si on affiche l'icon du mot de passe
  final bool? isPassword;

  /// boolean pour afficher ou non le mot de passe
  final bool hidePassword;

  /// fonction lors du click sur l'icon pour le mot de passe
  final Function? onVisibilityIconPressed;

  /// text lors que le champ n'est pas renseigné
  final String hintText;

  /// style du hintText
  final TextStyle? hintStyle;

  /// description en dessous du champ
  final String? helperText;

  /// style du helperText
  final TextStyle? helperStyle;

  final Color? backgroundColor;

  /// boolean pour ne pas pouvoir modifier le champ
  final bool enabled;

  /// définir le type d'input
  final TextInputType? keyboardType;

  /// définir le nombre de line maximum pour le textField
  final int? maxLines;

  /// définir le nombre de line minimum pour le textField
  final int? minLines;

  ///Temps d'attente avant de rentrer dans le onChanged (en millisecondes)
  final int? debounceTime;

  /// Focus Node de l'input
  final FocusNode? focusNode;

  /// Change le boutton save du clavier
  final TextInputAction? textInputAction;

  /// Utilisé pour le changement d'input
  void Function(String)? onFieldSubmitted;

  final AutovalidateMode? autoValidateMode;

  final EdgeInsetsGeometry? contentPadding;

  final bool? isCollapsed;

  TextAlignVertical? textAlignVertical;

  double? borderRadius;

  final void Function()? onTap;

  String? initialValue;

  final TextStyle? errorStyle;

  XInputTextField._({
    Key? key,
    this.controller,
    this.style,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.hidePassword = false,
    this.onVisibilityIconPressed,
    required this.hintText,
    this.onTap,
    this.hintStyle,
    this.helperText,
    this.helperStyle,
    this.enabled = true,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.debounceTime,
    this.backgroundColor,
    this.autoValidateMode,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.contentPadding,
    this.isCollapsed,
    this.textAlignVertical,
    this.borderRadius,
    this.initialValue,
    this.errorStyle,
  }) : super(key: key);

  /// TextField par defaut, required : hintText
  factory XInputTextField.basic({
    Key? key,
    TextEditingController? controller,
    TextStyle? style,
    String? Function(String?)? validator,
    Function()? onEditingComplete,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    void Function()? onTap,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? isPassword,
    bool hidePassword = false,
    Function? onVisibilityIconPressed,
    required String hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    bool enabled = true,
    TextInputType? keyboardType,
    int? maxLines,
    int? minLines,
    Color? backgroundColor,
    int? debounceTime,
    AutovalidateMode? autoValidateMode,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatter,
    EdgeInsetsGeometry? contentPadding,
    bool? isCollapsed,
    TextAlignVertical? textAlignVertical,
    double? borderRadius,
    String? initialValue,
    TextStyle? errorStyle,
  }) {
    return XInputTextField._(
      key: key,
      controller: controller,
      style: style,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isPassword: isPassword,
      hidePassword: hidePassword,
      onVisibilityIconPressed: onVisibilityIconPressed,
      hintText: hintText,
      hintStyle: hintStyle,
      helperText: helperText,
      helperStyle: helperStyle,
      backgroundColor: backgroundColor,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      debounceTime: debounceTime,
      autoValidateMode: autoValidateMode,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatter: inputFormatter,
      contentPadding: contentPadding,
      isCollapsed: isCollapsed,
      textAlignVertical: textAlignVertical,
      initialValue: initialValue,
      borderRadius: borderRadius,
      errorStyle: errorStyle,
    );
  }

  /// TextField pour commentaire avec maxLine et minLine à 3
  factory XInputTextField.multiLines({
    Key? key,
    TextEditingController? controller,
    TextStyle? style,
    String? Function(String?)? validator,
    Function()? onEditingComplete,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    void Function()? onTap,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? isPassword,
    bool hidePassword = false,
    Function? onVisibilityIconPressed,
    required String hintText,
    TextStyle? hintStyle,
    String? helperText,
    TextStyle? helperStyle,
    bool enabled = true,
    TextInputType? keyboardType,
    int? maxLines = 4,
    int? minLines = 4,
    int? debounceTime,
    Color? backgroundColor,
    AutovalidateMode? autoValidateMode,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatter,
    EdgeInsetsGeometry? contentPadding,
    bool? isCollapsed,
    TextAlignVertical? textAlignVertical,
    double? borderRadius,
    String? initialValue,
    TextStyle? errorStyle,
  }) {
    return XInputTextField._(
      key: key,
      controller: controller,
      onTap: onTap,
      style: style,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onSaved: onSaved,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isPassword: isPassword,
      hidePassword: hidePassword,
      onVisibilityIconPressed: onVisibilityIconPressed,
      hintText: hintText,
      hintStyle: hintStyle,
      helperText: helperText,
      helperStyle: helperStyle,
      backgroundColor: backgroundColor,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      debounceTime: debounceTime,
      autoValidateMode: autoValidateMode,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatter: inputFormatter,
      contentPadding: contentPadding,
      isCollapsed: isCollapsed,
      textAlignVertical: textAlignVertical,
      borderRadius: borderRadius,
      initialValue: initialValue,
      errorStyle: errorStyle,
    );
  }

  @override
  State<XInputTextField> createState() => _XTextFieldState();
}

class _XTextFieldState extends State<XInputTextField> {
  final FocusNode _fieldFocus = FocusNode();
  Color _colorField = inputDefault;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (widget.backgroundColor != null) _colorField = widget.backgroundColor!;

    _fieldFocus.addListener(() {
      if (_fieldFocus.hasFocus) {
        setState(() {
          _colorField = Colors.transparent;
        });
      } else {
        setState(() {
          _colorField = (widget.backgroundColor != null)
              ? widget.backgroundColor!
              : inputDefault;
        });
      }
    });
  }

  @override
  void dispose() {
    _fieldFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      inputFormatters: widget.inputFormatter,
      maxLines: (widget.hidePassword || widget.maxLines == null)
          ? 1
          : widget.maxLines,
      minLines: (widget.hidePassword || widget.minLines == null)
          ? 1
          : widget.minLines,
      controller: widget.controller,
      style: widget.style ?? bodyText2.copyWith(fontFamily: 'Anta'),
      focusNode: widget.focusNode ?? _fieldFocus,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      textAlignVertical: widget.textAlignVertical,
      onChanged: (v) {
        if (widget.onChanged != null) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce =
              Timer(Duration(milliseconds: widget.debounceTime ?? 0), () {
            widget.onChanged!(v);
          });
        }
      },
      onSaved: (value) {
        if (widget.onSaved != null) {
          widget.onSaved!(value);
        }
      },
      obscureText: widget.hidePassword,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: (value) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!("");
        }
      },
      decoration: textFormDecoration(
        fillColor: _colorField,
        isPassword: widget.isPassword,
        hidePassword: widget.hidePassword,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        onVisibilityIconPressed: widget.onVisibilityIconPressed,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        helperText: widget.helperText,
        helperStyle: widget.helperStyle,
        enabled: widget.enabled,
        contentPadding: widget.contentPadding,
        isCollapsed: widget.isCollapsed,
        borderRadius: widget.borderRadius,
        errorStyle: widget.errorStyle,
      ),
    );
  }
}
