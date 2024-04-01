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
  ItemData(backgroundColor, logo, "Bienvenue sur", "l'application",
      "Stacktim Booking"),
  ItemData(redLiquidSwipe, logo, "L'application qui vous", "permet de réserver",
      "vos sessions de jeu"),
  ItemData(backgroundColor, logo, "Prêt à jouer", "à vos jeux", "préférés ?"),
  ItemData(redLiquidSwipe, logo, "Avant d'accéder à ",
      "l'application, veuillez accepter le", " règlement de la salle"),
  ItemData(backgroundColor, logo, "J'accepte le ", "règlement de la salle", ""),
];

List<Widget> gameListGenerate = List.generate(
  gameList.length,
  (index) => Image.asset(
    gameList[index],
  ),
);

List<Widget> esportListGenerate = List.generate(
  esportList.length,
  (index) => Image.asset(
    fit: BoxFit.scaleDown,
    esportList[index],
  ),
);
