import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_app/core/constants/AppStrings.dart';
import 'package:time_app/core/constants/SharedPreferencesKey.dart';
import 'package:time_app/data/models/TimeZoneModel.dart';

abstract class TimeZoneLocalDataSource {
  Future<TimeZoneModel?> getSelectedTimeZoneModel();
  Future<List<TimeZoneModel>> getAllTimeZoneModel();
  Future<void> updateSelectedTimeZoneModel(TimeZoneModel tmz);
}

class TimeZoneLocalDataSourceImpl implements TimeZoneLocalDataSource {
  final SharedPreferences sharedPreferences;

  TimeZoneLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TimeZoneModel>> getAllTimeZoneModel() async {
    String jsonString = await rootBundle.loadString(AppStrings.jsonFilePath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<TimeZoneModel> list = (jsonMap['time_zones'] as List).map((timeZoneJson) => TimeZoneModel.fromJson(timeZoneJson)).toList();
    return list;
  }

  @override
  Future<TimeZoneModel?> getSelectedTimeZoneModel() async {
    String? jsonString = sharedPreferences.getString(SharedPreferencesKey.timeZone);
    if (jsonString == null) {
      return null;
    } else {
      final jsonMap = json.decode(jsonString);
      TimeZoneModel tzm = TimeZoneModel.fromJson(jsonMap);
      return tzm;
    }
  }

  @override
  Future<void> updateSelectedTimeZoneModel(TimeZoneModel tmz) async {
    final String jsonString = json.encode(tmz.toJson());
    sharedPreferences.setString(SharedPreferencesKey.timeZone, jsonString);
  }
}
