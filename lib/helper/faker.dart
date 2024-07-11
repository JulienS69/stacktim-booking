bool isProdDate() {
  DateTime prodDay = DateTime(2024, 7, 11, 17, 30);
  if (DateTime.now().isBefore(prodDay)) {
    return false;
  } else {
    return true;
  }
}
