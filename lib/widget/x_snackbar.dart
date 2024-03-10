import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';

const Duration _snackBarDisplayDuration = Duration(seconds: 3);

class XSnackbar extends SnackBar {
  const XSnackbar._({
    /// Contenu de la snackbar
    required Widget content,

    /// Duration de la snackbar
    required Duration duration,

    /// Alignement du texte
    TextAlign? textAlign,

    /// Context pour dissmiss la snackbar
    required BuildContext context,

    /// Icon affiché sur la snackbar
    Icon? icon,

    /// Couleur du background de la snacbar
    Color? backgroundColor,

    /// Détermine la couleur de l'icon
    Color? iconColor,

    /// Forme de la snackbar
    ShapeBorder? shapeBorder,

    /// Style du texte
    final TextStyle? textStyle,
  }) : super(
          content: content,
          duration: duration,
          backgroundColor: backgroundColor,
          shape: shapeBorder,
        );

  /// Snackbar informative
  factory XSnackbar.simple({
    required String message,
    required BuildContext context,
    TextAlign? textAlign,
    ShapeBorder? shapeBorder,
    Color? iconColor,
    Icon? icon,
    Duration duration = _snackBarDisplayDuration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return XSnackbar._(
      content: Row(
        children: [
          icon ??
              Icon(
                Icons.info_outline_rounded,
                color: iconColor ?? snackSimple,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                message,
                textAlign: textAlign ?? TextAlign.start,
                style: textStyle ??
                    styleWidget.copyWith(
                      fontSize: 14,
                      color: buttonHover,
                      overflow: TextOverflow.clip,
                    ),
                maxLines: 4,
              ),
            ),
          ),
          InkWell(
            child: const Icon(
              Icons.highlight_off_outlined,
              color: iconClose,
            ),
            onTap: () {
              /// Dissmiss la snackbar lors du clique sur l'icon "close"
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          )
        ],
      ),
      duration: duration,
      icon: icon,
      backgroundColor: backgroundColor ?? inputDefault,
      context: context,
      textAlign: textAlign,
      textStyle: textStyle,
      iconColor: iconColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  /// Snackbar de succès
  factory XSnackbar.success({
    required String message,
    required BuildContext context,
    TextAlign? textAlign,
    ShapeBorder? shapeBorder,
    Color? iconColor,
    Icon? icon,
    Duration duration = _snackBarDisplayDuration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return XSnackbar._(
      content: Row(
        children: [
          icon ??
              Icon(
                Icons.check_circle_outline,
                color: iconColor ?? greenChip,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                message,
                textAlign: textAlign ?? TextAlign.start,
                style: textStyle ??
                    styleWidget.copyWith(
                      fontSize: 14,
                      color: buttonHover,
                      overflow: TextOverflow.clip,
                    ),
                maxLines: 4,
              ),
            ),
          ),
          InkWell(
            child: const Icon(
              Icons.highlight_off_outlined,
              color: iconClose,
            ),
            onTap: () {
              /// Dissmiss la snackbar lors du clique sur l'icon "close"
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          )
        ],
      ),
      duration: duration,
      icon: icon,
      context: context,
      backgroundColor: backgroundColor ?? snackSucces,
      textAlign: textAlign,
      iconColor: iconColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  /// Snackbar warning
  factory XSnackbar.warning({
    required String message,
    required BuildContext context,
    TextAlign? textAlign,
    ShapeBorder? shapeBorder,
    Color? iconColor,
    Icon? icon,
    Duration duration = _snackBarDisplayDuration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return XSnackbar._(
      content: Row(
        children: [
          icon ??
              Icon(
                Icons.warning_amber,
                color: iconColor ?? yellowChip,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                message,
                textAlign: textAlign ?? TextAlign.start,
                style: textStyle ??
                    styleWidget.copyWith(
                      fontSize: 14,
                      color: buttonHover,
                      overflow: TextOverflow.clip,
                    ),
                maxLines: 4,
              ),
            ),
          ),
          InkWell(
            child: const Icon(
              Icons.highlight_off_outlined,
              color: iconClose,
            ),
            onTap: () {
              /// Dissmiss la snackbar lors du clique sur l'icon "close"
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          )
        ],
      ),
      duration: duration,
      icon: icon,
      context: context,
      backgroundColor: backgroundColor ?? snackWarning,
      textAlign: textAlign,
      iconColor: iconColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  /// Snackbar de mise à jour
  factory XSnackbar.update({
    required String message,
    required BuildContext context,
    TextAlign? textAlign,
    ShapeBorder? shapeBorder,
    Color? iconColor,
    Icon? icon,
    Duration duration = _snackBarDisplayDuration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return XSnackbar._(
      content: Row(
        children: [
          icon ??
              Icon(
                Icons.autorenew,
                color: iconColor ?? orangeChip,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                message,
                textAlign: textAlign ?? TextAlign.start,
                style: textStyle ??
                    styleWidget.copyWith(
                      fontSize: 14,
                      color: buttonHover,
                      overflow: TextOverflow.clip,
                    ),
                maxLines: 4,
              ),
            ),
          ),
          InkWell(
            child: const Icon(
              Icons.highlight_off_outlined,
              color: iconClose,
            ),
            onTap: () {
              /// Dissmiss la snackbar lors du clique sur l'icon "close"
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          )
        ],
      ),
      duration: duration,
      icon: icon,
      context: context,
      backgroundColor: backgroundColor ?? snackUpdate,
      textAlign: textAlign,
      iconColor: iconColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  /// Snackbar d'erreur
  factory XSnackbar.error({
    required String message,
    required BuildContext context,
    TextAlign? textAlign,
    ShapeBorder? shapeBorder,
    Color? iconColor,
    Icon? icon,
    Duration duration = _snackBarDisplayDuration,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return XSnackbar._(
      content: Row(
        children: [
          icon ??
              Icon(
                Icons.highlight_off_outlined,
                color: iconColor ?? redChip,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                message,
                textAlign: textAlign ?? TextAlign.start,
                style: textStyle ??
                    styleWidget.copyWith(
                      fontSize: 14,
                      color: buttonHover,
                      overflow: TextOverflow.clip,
                    ),
                maxLines: 4,
              ),
            ),
          ),
          InkWell(
            child: const Icon(
              Icons.highlight_off_outlined,
              color: iconClose,
            ),
            onTap: () {
              /// Dissmiss la snackbar lors du clique sur l'icon "close"
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          )
        ],
      ),
      duration: duration,
      icon: icon,
      context: context,
      backgroundColor: backgroundColor ?? snackError,
      textAlign: textAlign,
      iconColor: iconColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  // Méthode permettant d'afficher la snackbar choisie
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBar({
    required BuildContext context,
    required SnackBar snackBar,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
