bool isToday(DateTime date) {
  DateTime now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}
