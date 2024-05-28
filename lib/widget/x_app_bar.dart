import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';

import '../helper/style.dart';

class XPageHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const XPageHeader({
    super.key,
    this.color,
    this.centerTitle,
    this.leadingWidget,
    required this.title,
    this.style,
    this.automaticallyImplyLeading,
    this.imagePath,
  });

  ///changer le default background color
  final Color? color;

  ///ajouter un leading widget au text
  final Widget? leadingWidget;

  ///le label du texte
  final String title;

  ///centrer le titre
  final bool? centerTitle;

  //Leading like arrow back
  final bool? automaticallyImplyLeading;

  //
  final String? imagePath;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      toolbarHeight: 56,
      centerTitle: centerTitle ?? false,
      backgroundColor: color ?? black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      title: imagePath != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: title.isEmpty ? 0.0 : 8.0,
                      left: title.isEmpty ? 25 : 0.0),
                  child: Image.asset(imagePath!, width: 32, height: 40),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: imagePath?.isEmpty ?? true ? 0.0 : 25.0),
                  child: Text(
                    title,
                    style: style ??
                        titleText1.copyWith(
                            color: Colors.white,
                            fontFamily: 'Anta',
                            fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          : Tooltip(
              message: title,
              child: Text(
                title,
                style: style ??
                    titleText1.copyWith(
                        color: Colors.white, fontFamily: 'Anta'),
              ),
            ),
      leading: leadingWidget,
    );
  }
}
