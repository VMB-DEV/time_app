import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_app/data/data_source/SettingsLocalDataSource.dart';
import 'package:time_app/data/data_source/TimeZoneLocalDataSource.dart';
import 'package:time_app/data/repositories/SettingsRepositoryImpl.dart';
import 'package:time_app/data/repositories/TimeZoneRepositoryImpl.dart';
import 'package:time_app/domain/repositories/SettingsRepository.dart';
import 'package:time_app/domain/repositories/TimeZoneRepository.dart';
import 'package:time_app/domain/usecases/settings/GetSettings.dart';
import 'package:time_app/domain/usecases/settings/UpdateSettings.dart';
import 'package:time_app/domain/usecases/timeZones/GetAllTimeZones.dart';
import 'package:time_app/domain/usecases/timeZones/GetSelectedTimeZone.dart';
import 'package:time_app/domain/usecases/timeZones/SetSelectedTimeZone.dart';
import 'package:time_app/presentation/state_management/SettingsProvider.dart';
import 'package:time_app/presentation/state_management/TimeZoneProvider.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Use cases
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAllTimeZonesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSelectedTimeZoneUseCase(getIt()));
  getIt.registerLazySingleton(() => SetSelectedTimeZoneUseCase(getIt()));

  getIt.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<TimeZoneRepository>(
        () => TimeZoneRepositoryImpl(localDataSource: getIt()),
  );

  getIt.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSourceImpl(sharedPreferences: getIt()),
  );
  getIt.registerLazySingleton<TimeZoneLocalDataSource>(
        () => TimeZoneLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  getIt.registerFactory(
        () => SettingsProvider(
      getSettingsUseCase: getIt(),
      updateSettingsUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
        () => TimeZoneProvider(
          getAllTimeZonesUseCase: getIt(),
          getSelectedTimeZoneUseCase: getIt(),
          setSelectedTimeZoneUseCase: getIt(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
