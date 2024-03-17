String formatTime(DateTime dateTime) {
  // Formater l'heure et les minutes avec un 0 en préfixe si nécessaire
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  return "${hour}h$minute";
}

String getMonthName(int month) {
  // Tableau de noms des mois en français
  List<String> monthNames = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];

  // Récupérer le nom du mois correspondant à l'indice (mois - 1 car l'index commence à 0)
  return monthNames[month - 1];
}

String formatDateAndTime(
    {required String bookedAt,
    required String beginAt,
    required String endAt}) {
  // Convertir la date réservée en DateTime
  DateTime bookedDateTime = DateTime.parse(bookedAt);

  // Séparer les heures, minutes et secondes du début et de la fin
  List<String> beginTimeParts = beginAt.split(':');
  List<String> endTimeParts = endAt.split(':');

  // Convertir les parties d'heures en entiers
  int beginHour = int.parse(beginTimeParts[0]);
  int beginMinute = int.parse(beginTimeParts[1]);
  int endHour = int.parse(endTimeParts[0]);
  int endMinute = int.parse(endTimeParts[1]);

  // Créer les objets DateTime pour le début et la fin
  DateTime beginDateTime = DateTime(bookedDateTime.year, bookedDateTime.month,
      bookedDateTime.day, beginHour, beginMinute);
  DateTime endDateTime = DateTime(bookedDateTime.year, bookedDateTime.month,
      bookedDateTime.day, endHour, endMinute);

  // Formater les dates et heures dans le format souhaité
  String formattedBookedDate =
      "${bookedDateTime.day} ${getMonthName(bookedDateTime.month)}";
  String formattedTimeRange =
      "${formatTime(beginDateTime)} à ${formatTime(endDateTime)}";

  return "Le $formattedBookedDate de $formattedTimeRange";
}
