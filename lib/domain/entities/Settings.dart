import 'package:time_app/data/models/SettingsModel.dart';

class Settings {
  final bool darkTheme;
  final bool amPmFormat;
  final bool firstLaunch;

  Settings({
    required this.darkTheme,
    required this.amPmFormat,
    required this.firstLaunch,
  });

  factory Settings.defaultState() => Settings(darkTheme: false, amPmFormat: false, firstLaunch: true);
}