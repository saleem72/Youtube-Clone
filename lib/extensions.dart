//

extension DurationReadablr on Duration {
  String get readable {
    return inHours > 0
        ? '${inHours.twoDigits}:${inMinutes.remainder(60).twoDigits}:${inSeconds.remainder(60).twoDigits}'
        : '${inMinutes.remainder(60).twoDigits}:${inSeconds.remainder(60).twoDigits}';
  }
}

extension IntTowDigits on int {
  String get twoDigits => toString().padLeft(2, "0");
}

extension ParseDuration on String {
  Duration parseDuration() {
    try {
      int hours = 0;
      int minutes = 0;
      int micros;
      List<String> parts = split(':');
      if (parts.length > 2) {
        hours = int.parse(parts[parts.length - 3]);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[parts.length - 2]);
      }
      micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    } on Exception catch (_) {
      return Duration.zero;
    } catch (_) {
      return Duration.zero;
    }
  }
}
