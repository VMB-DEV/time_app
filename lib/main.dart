import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:time_app/core/constants/AppTabName.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/presentation/state_management/SettingsProvider.dart';
import 'package:time_app/presentation/state_management/TimeZoneProvider.dart';
import 'package:time_app/presentation/tabs/AppTab.dart';
import 'package:time_app/presentation/tabs/FirstLaunch.dart';
import 'package:time_app/presentation/theme/Themes.dart';
import 'core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final timeZoneProvider = TimeZoneProvider(
      getAllTimeZonesUseCase: di.getIt(),
      getSelectedTimeZoneUseCase: di.getIt(),
      setSelectedTimeZoneUseCase: di.getIt()
  );
  final settingsProvider = SettingsProvider(
      getSettingsUseCase: di.getIt(),
      updateSettingsUseCase: di.getIt()
  );

  await Future.wait([
    timeZoneProvider.loadTimeZones(),
    settingsProvider.loadSettings(),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => timeZoneProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => settingsProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider> (
      builder: (context, SettingsProvider settingsProvider, child) {
        Settings settings = settingsProvider.settings;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Time App',
          theme: settings.darkTheme == true ? darkTheme : lightTheme,
          home: settings.firstLaunch ? const FirstLaunch() : const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<AppTab> navTabs = tabs
      .where( (tab) => tab.tabName != AppTabName.firstLaunch)
      .toList();
      // .map((tab) => tab.widget)
      // .toList();

  int currentIndex = 1;

  void _onNavBarTap(index) {
    setState(() { currentIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: navTabs.map((tab) => tab.widget).toList() ,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onNavBarTap(index),
        backgroundColor: Theme.of(context).colorScheme.primary,
        mouseCursor: SystemMouseCursors.grab,
        selectedIconTheme: IconThemeData(
            // color: Colors.amberAccent,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            size: 37
        ),
        // selectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        unselectedIconTheme: IconThemeData(
          // color: Theme.of(context).colorScheme.onPrimary,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 31
        ),
        showUnselectedLabels: false,
        items: navTabs
          .map((tab) => BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label))
          .toList(),
      ),
    );
  }
}