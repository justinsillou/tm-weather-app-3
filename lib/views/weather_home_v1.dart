import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_3/models/weather/weather_data.dart';
import 'package:weather_app_3/views/day_weather_widget.dart';
import 'package:weather_app_3/views/loading_widget.dart';
import 'package:weather_app_3/views/weather_home.dart';

class WeatherHomeV1 extends StatefulWidget {
  const WeatherHomeV1({super.key});

  @override
  State<WeatherHomeV1> createState() => _WeatherHomeV1State();
}

class _WeatherHomeV1State extends State<WeatherHomeV1> {
  bool isLoading = false;
  WeatherData? weatherData;

  refresh({
    double latitude = 50.61,
    double longitude = 3.13,
  }) async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    var response = await Dio().get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current_weather': true,
        'daily': [
          'weathercode',
          'temperature_2m_max',
          'temperature_2m_min',
          'apparent_temperature_max',
          'apparent_temperature_min',
          'sunrise',
          'sunset'
        ],
        'timezone': 'Europe/Paris',
        'start_date': '2023-09-17',
        'end_date': '2023-10-17',
      },
    );

    setState(() {
      weatherData = WeatherData.fromJson(response.data);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo V1'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WeatherHome(),
                ),
              );
            },
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        TextButton(
          onPressed: weatherData != null
              ? () {
                  refresh();
                }
              : null,
          child: const Center(child: Text("Refresh")),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget();
    }

    if (weatherData != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: weatherData!.daily.time.length,
          itemBuilder: (context, index) => DayWeatherWidget(
            weatherDay: weatherData!.daily.getDayByIndex(index: index),
            interactive: false,
          ),
        ),
      );
    }

    return Center(
      child: ElevatedButton(
        onPressed: () => refresh(),
        child: const Text("Charger la météo"),
      ),
    );
  }
}
