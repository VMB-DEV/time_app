import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/domain/repositories/SettingsRepository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Settings> execute() => repository.getSettings();
}
