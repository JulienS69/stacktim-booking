import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/widget/x_chip.dart';

import 'color.dart';

enum XChipColor { green, red, blue }

const double pagePadding = 16.0;
const double buttonHeight = 56.0;
const double bottomPaddingForButton = 150.0;

enum LocalStorageKey {
  jwt,
  agreement,
}

enum StatusEnumKey {
  passee,
  inProgress,
  inComming,
}

class StatusSlugs {
  static const String passee = "passee";
  static const String inProgress = "en-cours";
  static const String inComming = "a-venir";
}

class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

List<ItemData> liquidSwipeData = [
  ItemData(blackLiquidSwipe, logo, "Bienvenue sur", "l'application",
      "Stacktim Booking"),
  ItemData(backgroundColor, logo, "L'application qui te", "permet de réserver",
      "tes sessions de jeu"),
  ItemData(blackLiquidSwipe, logo, "Prêt à jouer", "à tes jeux", "préférés ?"),
  ItemData(
      backgroundColor,
      logo,
      "Avant d'accéder à ",
      "l'application, il est nécéssaire",
      "d'accepter le règlement de la salle"),
  ItemData(
      blackLiquidSwipe, logo, "J'accepte le ", "règlement de la salle", ""),
];

List<Widget> gameListGenerate = List.generate(
  gameList.length,
  (index) => ClipRRect(
    borderRadius: BorderRadius.circular(12.0),
    child: Image.asset(
      gameList[index],
    ),
  ),
);

List<Widget> esportListGenerate = List.generate(
  esportList.length,
  (index) => ClipRRect(
    borderRadius: BorderRadius.circular(12.0),
    child: Image.asset(
      fit: BoxFit.scaleDown,
      esportList[index],
    ),
  ),
);

List<Widget> roomPictureListGenerate = List.generate(
  roomPictureList.length,
  (index) => ClipRRect(
    borderRadius: BorderRadius.circular(12.0),
    child: Image.asset(
      fit: BoxFit.scaleDown,
      roomPictureList[index],
    ),
  ),
);

List<Image> loginImageListGenerate = List.generate(
  loginImageList.length,
  (index) => Image.asset(loginImageList[index]),
);

XChip getChipByStatusTag(String? tag) {
  switch (tag) {
    case StatusSlugs.passee:
      return XChip.chipStatus(
        label: "Passée".tr.capitalizeFirst!,
        chipColor: XChipColor.red,
      );
    case StatusSlugs.inComming:
      return XChip.chipStatus(
        label: "A venir".tr.capitalizeFirst!,
        chipColor: XChipColor.blue,
      );
    case StatusSlugs.inProgress:
      return XChip.chipStatus(
        label: "En cours".tr.capitalizeFirst!,
        chipColor: XChipColor.green,
      );
    default:
      return XChip.chipStatus(
        label: "Aucun status".tr.capitalizeFirst!,
        chipColor: XChipColor.red,
      );
  }
}

XChipColor getColorChipByStatusTag(String tag) {
  switch (tag) {
    case StatusSlugs.passee:
      return XChipColor.red;
    case StatusSlugs.inComming:
      return XChipColor.blue;
    case StatusSlugs.inProgress:
      return XChipColor.green;

    default:
      return XChipColor.red;
  }
}

String getStringByStatusTag(String tag) {
  switch (tag) {
    case StatusSlugs.passee:
      return 'Passée';
    case StatusSlugs.inComming:
      return "A venir";
    case StatusSlugs.inProgress:
      return 'En cours';

    default:
      return '';
  }
}

Color getColorsByStatusTag({
  required String statusTag,
}) {
  if (statusTag == StatusSlugs.inProgress) {
    return greenChip;
  } else if (statusTag == StatusSlugs.passee) {
    return redChip;
  } else {
    return blueChip;
  }
}

String formatDateInLocal({
  required String datePicked,
}) {
  String formattedDate = datePicked;
  DateTime date = DateTime.parse(formattedDate);
  formattedDate = DateFormat('dd MMMM yyyy', 'fr').format(date);
  return formattedDate;
}

String teamsUrlOfUser({required String userMail}) {
  return "https://teams.microsoft.com/l/chat/0/0?users=$userMail&message=[Message envoyé depuis l'application Stacktim Booking]";
}

// Rate for SENTRY
double getTracesSampleRateForSentry({
  required String environnement,
}) {
  double traceRate = 0.2;
  if (environnement == "PROD" || environnement == "DEMO") {
    traceRate = 0.2;
  } else if (environnement == "RD" || environnement == "RC") {
    traceRate = 1.0;
  }
  return traceRate;
}

Icon faIconWithCode(String iconCode, {double? size, Color? color}) {
  return Icon(
    IconDataRegular(
      int.parse('0x$iconCode'),
    ),
    size: size ?? 20,
    color: color,
  );
}
