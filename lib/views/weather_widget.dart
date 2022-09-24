import 'package:flutter/material.dart';
import 'package:weather_app_3/models/weather_data.dart';
import 'package:weather_app_3/views/current_weather_widget.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherWidget({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.topCenter,
      child: CurrentWeatherWidget(
        weatherCurrent: weatherData.currentWeather,
      ),
    );
  }
}
