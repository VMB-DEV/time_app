import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/domain/repositories/TimeZoneRepository.dart';

class SetSelectedTimeZoneUseCase {
  final TimeZoneRepository repository;

  SetSelectedTimeZoneUseCase(this.repository);

  Future<void> execute(TimeZone newTimeZone) => repository.updateSelectedTimeZone(newTimeZone);
}
