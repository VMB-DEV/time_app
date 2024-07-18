import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/presentation/state_management/TimeZoneProvider.dart';

class TimeZonesTab extends StatelessWidget {
  const TimeZonesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeZoneProvider>(
      builder: (context, TimeZoneProvider timeZoneProvider, child) {
        TimeZone? selectedTimeZone = timeZoneProvider.selectedTimeZone;
        List<TimeZone> timeZones = timeZoneProvider.timeZones;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Time zones'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          body: ListView.builder(
            itemCount: timeZones.length,
            itemBuilder: (context, index) {
              TimeZone timeZone = timeZones.elementAt(index);
              bool state = timeZone.offset == selectedTimeZone?.offset;
              return SwitchListTile(
                title: Text(timeZone.mainCity),
                subtitle: Text('${timeZone.offset} (${timeZone.code})'),
                activeColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                inactiveThumbColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                value: state,
                onChanged: (bool value) {
                  timeZoneProvider.setTimeZoneTo(timeZone);
                },
              );
            },
          ),
        );
      },
    );
  }
}