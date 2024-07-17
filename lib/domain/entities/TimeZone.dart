class TimeZone {
  final String offset;
  final String mainCity;
  final String code;
  final int intOffset;

  TimeZone({
    required this.offset,
    required this.mainCity,
    required this.code,
    required this.intOffset,
  });

  DateTime getDateTime() {
    return DateTime.now().toUtc().add(Duration(hours: intOffset));
  }
  factory TimeZone.from(TimeZone timeZone) {
    return TimeZone(
      offset: timeZone.offset,
      mainCity: timeZone.mainCity,
      code: timeZone.code,
      intOffset: timeZone.intOffset,
    );
  }
}