import 'package:time_app/domain/entities/TimeZone.dart';

abstract class TimeZoneRepository {
  Future<List<TimeZone>> getAllTimeZones();
  Future<TimeZone> getSelectedTimeZone();
  Future<void> updateSelectedTimeZone(TimeZone newTimeZone);
}
