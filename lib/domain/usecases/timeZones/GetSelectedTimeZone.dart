import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/domain/repositories/TimeZoneRepository.dart';

class GetSelectedTimeZoneUseCase {
  final TimeZoneRepository repository;

  GetSelectedTimeZoneUseCase(this.repository);

  Future<TimeZone> execute() => repository.getSelectedTimeZone();
}
