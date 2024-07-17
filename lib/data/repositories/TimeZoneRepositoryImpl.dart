import 'package:time_app/data/data_source/TimeZoneLocalDataSource.dart';
import 'package:time_app/data/models/TimeZoneModel.dart';
import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/domain/repositories/TimeZoneRepository.dart';

class TimeZoneRepositoryImpl implements TimeZoneRepository {
  final TimeZoneLocalDataSource localDataSource;

  TimeZoneRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TimeZone>> getAllTimeZones() async {
    final List<TimeZone> list = await localDataSource.getAllTimeZoneModel();
    return list;
  }

  @override
  Future<void> updateSelectedTimeZone(TimeZone newTimeZone) async {
    final tmz = TimeZoneModel.from(newTimeZone);
    localDataSource.updateSelectedTimeZoneModel(tmz);
  }

  @override
  Future<TimeZone> getSelectedTimeZone() async {
    final TimeZoneModel? timeZoneModel = await localDataSource.getSelectedTimeZoneModel();
    if (timeZoneModel == null) {
      TimeZone localTimeZone = await getLocalTimeZone();
      updateSelectedTimeZone(localTimeZone);
      return localTimeZone;
    } else {
      return TimeZone.from(timeZoneModel);
    }
  }

  Future<TimeZone> getLocalTimeZone() async {
    int offsetInt = await getOffsetInt();
    List<TimeZone> list = await getAllTimeZones();
    TimeZone timeZone = list.where((tz) => tz.intOffset == offsetInt).first;
    return timeZone;
  }
  Future<int> getOffsetInt() async {
    DateTime utcZero = DateTime.now().toUtc();
    DateTime utcLocal = utcZero.toLocal();
    int dayZero = utcZero.day;
    int dayLocal = utcLocal.day;
    int hourZero = utcZero.hour;
    int hourLocal = utcLocal.hour;
    int offsetHour;
    if ( dayLocal < dayZero ) {
      offsetHour = hourZero - (24 - hourLocal);
    } else if ( dayLocal > dayZero ) {
      offsetHour = (24 - hourZero) + hourLocal;
    } else {
      offsetHour = hourLocal - hourZero;
    }
    return offsetHour;
  }
}
