import 'package:time_app/domain/entities/Settings.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings();
  Future<void> updateSettings(Settings newSettings);
}