import 'package:flutter/widgets.dart';
import 'package:stacktim_booking/helper/strings.dart';

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

String getStatusString(StatusEnumKey status) {
  switch (status) {
    case StatusEnumKey.passee:
      return "Passée";
    case StatusEnumKey.inProgress:
      return "En cours";
    case StatusEnumKey.inComming:
      return "À venir";
    default:
      return "Statut inconnu";
  }
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
