import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/strings.dart';

class XProfilWidget extends StatelessWidget {
  String title = "";
  String? imageAsset = "";
  double? imageHeight;
  void Function() onTap;
  Widget? widget;

  XProfilWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.imageHeight,
    this.widget,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap();
      },
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          Text(
            title,
          ),
          const Spacer(),
          widget ??
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Image.asset(
                    height: imageHeight ?? 25,
                    imageAsset ?? coinLogo,
                  ),
                ),
              )
        ],
      ),
    );
  }
}
