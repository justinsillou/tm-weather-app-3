import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_3/models/weather_data.dart';

class WeatherDataCubit extends Cubit<WeatherData?> {
  WeatherDataCubit() : super(null);

  refresh() async {
    var response = await Dio().get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        'latitude': 52.52,
        'longitude': 13.41,
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
      },
    );

    WeatherData weatherData = WeatherData.fromJson(response.data);

    emit(weatherData);
  }
}
