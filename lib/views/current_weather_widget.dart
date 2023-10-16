import 'package:flutter/material.dart';
import 'package:weather_app_3/models/weather/weather_current.dart';
import 'package:weather_app_3/utils/utils.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherCurrent _weatherCurrent;
  const CurrentWeatherWidget({super.key, required WeatherCurrent weatherCurrent}) : _weatherCurrent = weatherCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(Utils.weatherCodeToImage(
              _weatherCurrent.weatherCode,
            )),
            Positioned.fill(
              child: Center(
                child: Text(
                  "${_weatherCurrent.temperature}°C",
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          "Wind speed: ${_weatherCurrent.windSpeed} m/s",
        ),
        Text(
          "Wind direction: ${_weatherCurrent.windDirection}°",
        ),
      ],
    );
  }
}
