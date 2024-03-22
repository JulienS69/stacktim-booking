enum XChipColor { green, red, blue }

const double pagePadding = 16.0;
const double buttonHeight = 56.0;
const double bottomPaddingForButton = 150.0;

enum LocalStorageKey {
  jwt,
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
