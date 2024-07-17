import 'package:flutter/material.dart';
import 'package:time_app/core/constants/AppTabName.dart';
import 'package:time_app/presentation/tabs/FirstLaunch.dart';
import 'package:time_app/presentation/tabs/SettingsTab.dart';
import 'package:time_app/presentation/tabs/TimeTab.dart';
import 'package:time_app/presentation/tabs/TimeZoneTab.dart';

class AppTab {
  final AppTabName tabName;
  final IconData icon;
  final Widget widget;
  final String label;

  AppTab({
    required this.tabName,
    required this.icon,
    required this.widget,
    required this.label,
  });
}

List<AppTab> tabs = [
  AppTab(tabName: AppTabName.timeZones, label: 'TimeZones', icon: Icons.location_on_outlined, widget: const TimeZonesTab()),
  AppTab(tabName: AppTabName.time, label: 'Time', icon: Icons.access_time, widget: const TimeTab()),
  AppTab(tabName: AppTabName.settings, label: 'Settings', icon: Icons.settings, widget: const SettingsTab()),
  AppTab(tabName: AppTabName.firstLaunch, label: 'FirstLaunch', icon: Icons.error_outline, widget: const FirstLaunch()),
];

