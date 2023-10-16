import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/models/air_quality/air_quality_data.dart';
import 'package:weather_app_3/models/weather/weather_day.dart';
import 'package:weather_app_3/utils/utils.dart';
import 'package:weather_app_3/views/new_route_selected_day_widget.dart';

class SelectedDayWidget extends StatefulWidget {
  final WeatherDay day;

  const SelectedDayWidget({
    super.key,
    required this.day,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SelectedDayWidgetState createState() => _SelectedDayWidgetState();
}

class _SelectedDayWidgetState extends State<SelectedDayWidget> {
  bool isLoading = false;
  AirQualityData? airQualityData;

  get day => widget.day;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewRouteSelectedDay(
                    day: day,
                  )),
        );
      },
      // color text black for the TextButton
      style: TextButton.styleFrom(foregroundColor: Colors.black),
      child: Column(
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
      ),
    );
  }
}
