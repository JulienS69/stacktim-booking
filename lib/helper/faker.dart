bool isProdDate() {
  DateTime prodDay = DateTime(2023, 9, 20, 8, 30);
  if (DateTime.now().isBefore(prodDay)) {
    return false;
  } else {
    return true;
  }
}
