// DateTime generateExpirationDateTime(Duration duration) {
//   return DateTime.now().add(duration);
// }

DateTime get defaultExpirationDateTime =>
    DateTime.now().add(const Duration(minutes: 1));
