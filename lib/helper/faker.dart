bool isProdDate() {
  DateTime prodDay = DateTime(2023, 10, 1, 12, 00);
  if (DateTime.now().isBefore(prodDay)) {
    return false;
  } else {
    return true;
  }
}
