import 'package:flutter/material.dart';
import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/domain/usecases/timeZones/GetAllTimeZones.dart';
import 'package:time_app/domain/usecases/timeZones/GetSelectedTimeZone.dart';
import 'package:time_app/domain/usecases/timeZones/SetSelectedTimeZone.dart';

class TimeZoneProvider with ChangeNotifier {
  final GetAllTimeZonesUseCase getAllTimeZonesUseCase;
  final GetSelectedTimeZoneUseCase getSelectedTimeZoneUseCase;
  final SetSelectedTimeZoneUseCase setSelectedTimeZoneUseCase;

  List<TimeZone> _timeZones = [];
  TimeZone? _selectedTimeZone;

  TimeZoneProvider({
    required this.getAllTimeZonesUseCase,
    required this.getSelectedTimeZoneUseCase,
    required this.setSelectedTimeZoneUseCase,
  });
  
  List<TimeZone> get timeZones => _timeZones;
  TimeZone? get selectedTimeZone => _selectedTimeZone;

  Future<void> loadTimeZones() async {
    _selectedTimeZone = await getSelectedTimeZoneUseCase.execute();
    _timeZones = await getAllTimeZonesUseCase.execute();
    notifyListeners();
  }

  Future<void> setTimeZoneTo(TimeZone newTimeZone) async {
    setSelectedTimeZoneUseCase.execute(newTimeZone);
    _selectedTimeZone = newTimeZone;
    notifyListeners();
  }
}
