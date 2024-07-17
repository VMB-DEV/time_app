import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/presentation/state_management/SettingsProvider.dart';

class FirstLaunch extends StatefulWidget {
  const FirstLaunch({super.key});

  @override
  State<FirstLaunch> createState() => _FirstLaunchState();
}

class _FirstLaunchState extends State<FirstLaunch> {

  bool darkTheme = Settings.defaultState().darkTheme;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);


    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Choose a theme color'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  elevation: 0,
                  highlightColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightElevation: 0,
                  onPressed: () {
                    setState(() { darkTheme = true; });
                    settingsProvider.updateDarkThemeTo(true);
                  },
                  child: Text(
                    'dark theme',
                    style: TextStyle(
                      color: darkTheme == true ? Theme.of(context).colorScheme.surfaceContainerLowest
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                      fontSize: 30,
                      fontWeight: darkTheme ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const Text(
                  " / ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RawMaterialButton(
                  elevation: 0,
                  highlightColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightElevation: 0,
                  onPressed: () {
                    setState(() { darkTheme = false; });
                    settingsProvider.updateDarkThemeTo(false);
                  },
                  // onPressed: () { settingsProvider.updateDarkThemeTo(false); },
                  child: Text(
                    'light theme',
                    style: TextStyle(
                      color: darkTheme == false ? Theme.of(context).colorScheme.surfaceContainerLowest
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                      fontSize: 30,
                      fontWeight: !darkTheme ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    settingsProvider.updateSettings(
                      Settings(
                        darkTheme: darkTheme,
                        amPmFormat: Settings.defaultState().amPmFormat,
                        firstLaunch: false,
                      )
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    size: 35,
                  ),
                ),
              )
            ]
        ),
        // ),
      ),
    );
  }
}

