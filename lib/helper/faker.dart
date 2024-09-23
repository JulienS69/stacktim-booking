bool isProdDate() {
  DateTime prodDay = DateTime(2024, 9, 24, 8, 30);
  if (DateTime.now().isBefore(prodDay)) {
    return false;
  } else {
    return true;
  }
}
