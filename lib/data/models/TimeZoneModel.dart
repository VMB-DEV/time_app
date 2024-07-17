import 'package:time_app/domain/entities/TimeZone.dart';

class TimeZoneModel extends TimeZone {
  TimeZoneModel({
    required String offset,
    required String mainCity,
    required String code,
    required int intOffset,
  }) : super(offset: offset, mainCity: mainCity, code: code, intOffset: intOffset);

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) {
    return TimeZoneModel(
      offset: json['offset'],
      mainCity: json['main_city'],
      code: json['code'],
      intOffset: int.parse(json['offset'].toString().substring(3, 6)),
    );
  }

  factory TimeZoneModel.from(TimeZone tz) {
    return TimeZoneModel(
      offset: tz.offset,
      mainCity: tz.mainCity,
      code: tz.code,
      intOffset: tz.intOffset,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offset': offset,
      'main_city': mainCity,
      'code': code,
    };
  }
}
