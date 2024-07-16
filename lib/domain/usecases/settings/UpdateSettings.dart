
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/domain/repositories/SettingsRepository.dart';

class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<void> execute(Settings newSettings) => repository.updateSettings(newSettings);
}