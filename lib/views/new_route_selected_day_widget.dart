import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/models/weather/weather_day.dart';

class NewRouteSelectedDay extends StatelessWidget {
  final WeatherDay day;

  const NewRouteSelectedDay({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.yMMMMEEEEd().format(day.day),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          // Ajout des autres informations concernant la journée
          Text("Min: ${day.temperature2mMin}°C"),
          Text("Max: ${day.temperature2mMax}°C"),
          Text("Sunrise: ${day.sunrise}"),
          Text("Sunset: ${day.sunset}"),
        ],
      )),
    );
  }
}
