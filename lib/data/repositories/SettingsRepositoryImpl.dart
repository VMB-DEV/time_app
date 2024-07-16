import 'package:time_app/data/data_source/SettingsLocalDataSource.dart';
import 'package:time_app/data/models/SettingsModel.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/domain/repositories/SettingsRepository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Settings> getSettings() async {
    return await localDataSource.getSettings();
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    await localDataSource.updateSettings(SettingsModel.from(settings));
  }
}