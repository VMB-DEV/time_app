import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey.shade700,
    secondary: Colors.blueGrey.shade700,
    surface: Colors.blueGrey.shade900,
    tertiary: Colors.amber.shade700,
    surfaceContainerLow: Colors.amber.shade800,
    surfaceContainerLowest: Colors.amber.shade400,
    surfaceContainerHigh: Colors.grey.shade700,
  ),
  useMaterial3: true,
);

ThemeData lightTheme = ThemeData(
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade700),
  colorScheme: ColorScheme.light(
    primary: Colors.blueGrey.shade700,
    secondary: Colors.blueGrey.shade400,
    surface: Colors.grey.shade200,
    background: Colors.grey.shade300,
    tertiary: Colors.greenAccent,
    surfaceContainerLow: Colors.green.shade200,
    surfaceContainerLowest: Colors.green.shade700,
    surfaceContainerHigh: Colors.grey.shade700,
  ),
  useMaterial3: true,
);
