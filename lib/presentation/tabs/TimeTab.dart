import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_app/domain/entities/TimeZone.dart';
import 'package:time_app/presentation/state_management/SettingsProvider.dart';
import 'package:time_app/presentation/state_management/TimeZoneProvider.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  Stream<DateTime> timeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  String formatTime(DateTime time, TimeZone timeZone, bool amPmFormat) {
    final adjustedTime = time.toUtc().add(Duration(hours: timeZone.intOffset));
    final hour = (amPmFormat ? (adjustedTime.hour > 12 ? adjustedTime.hour - 12 : adjustedTime) : adjustedTime.hour).toString().padLeft(2, '0');
    final minute = adjustedTime.minute.toString().padLeft(2, '0');
    final second = adjustedTime.second.toString().padLeft(2, '0');
    final period = adjustedTime.hour < 12 ? 'AM' : 'PM';

    return '$hour : $minute : $second $period';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TimeZoneProvider, SettingsProvider>(
      builder: (context, timeZoneProvider, settingsProvider, _) {
        final TimeZone? timeZone = timeZoneProvider.selectedTimeZone;
        final bool amPmFormat = settingsProvider.settings.amPmFormat;


        return timeZone == null ? const Center(child: CircularProgressIndicator()) : Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeZone.mainCity,
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  '${timeZone.offset} (${timeZone.code})',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<DateTime>(
                  stream: timeStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final formattedTime = formatTime(snapshot.data!, timeZone, amPmFormat);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formattedTime.substring(0, 12),
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          amPmFormat ? Text(
                            formattedTime.substring(12),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ) : const SizedBox(width: 1, height: 1,),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}