import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/domain/repositories/TimeZoneRepository.dart';

class GetAllTimeZonesUseCase {
  final TimeZoneRepository repository;

  GetAllTimeZonesUseCase(this.repository);

  Future<List<TimeZone>> execute() => repository.getAllTimeZones();
}
