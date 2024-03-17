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
