import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/presentation/state_management/SettingsProvider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  String _onOff(bool isOn) => isOn ? 'off' : 'on';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider> (
        builder: (context, SettingsProvider settingsProvider, child) {
          final Settings settings = settingsProvider.settings;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            body: Column(
              children: <Widget>[
                SwitchListTile(
                  title: const Text('DarkTheme'),
                  subtitle: Text('Tape to turn ${_onOff(settings.darkTheme)} darkTheme'),
                  activeColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                  inactiveThumbColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  value: settings.darkTheme,
                  onChanged: (bool value) {
                    settingsProvider.updateDarkThemeTo(value);
                  },
                ),
                // const Divider(height: 0),
                SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                  inactiveThumbColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  value: settings.amPmFormat,
                  onChanged: (bool value) {
                    settingsProvider.updateAmPmFormat(value);
                  },
                  title: const Text('12 hours format'),
                  subtitle: Text( 'Tape to turn ${_onOff(settings.amPmFormat)} the twelve hours format'),
                ),
                // const Divider(height: 0),
              ],
            ),
          );
        }
    );
  }
}
