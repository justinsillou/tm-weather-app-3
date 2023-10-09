import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/models/weather_day.dart';
import 'package:weather_app_3/utils/utils.dart';

class SelectedDayWidget extends StatelessWidget {
  WeatherDay day;

  SelectedDayWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Utils.weatherCodeToImage(day.weatherCode),
              height: 50,
            ),
            const SizedBox(width: 8.0),
            Text(
              DateFormat.yMMMMEEEEd().format(day.day),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Min: ${day.temperature2mMin}°C",
            ),
            Text(
              "Max: ${day.temperature2mMax}°C",
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sunrise: ${DateFormat.Hms().format(day.sunrise)}",
            ),
            Text(
              "Sunset: ${DateFormat.Hms().format(day.sunset)}",
            ),
          ],
        ),
      ],
    );
  }
}
