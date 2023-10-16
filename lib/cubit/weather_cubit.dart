import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_3/models/weather/weather_data.dart';
import 'package:weather_app_3/models/weather/weather_day.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  refresh({
    double latitude = 50.61,
    double longitude = 3.13,
  }) async {
    emit(WeatherLoadingState());

    await Future.delayed(const Duration(seconds: 2));

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

    emit(WeatherLoadedState(
      weatherData: WeatherData.fromJson(response.data),
    ));
  }

  select(WeatherDay day) {
    if (state is WeatherLoadedState) {
      emit(WeatherSelectedState(
        weatherData: (state as WeatherLoadedState).weatherData,
        weatherDay: day,
      ));
    }
  }

  unselect() {
    if (state is WeatherSelectedState) {
      emit(WeatherLoadedState(
        weatherData: (state as WeatherSelectedState).weatherData,
      ));
    }
  }

  @override
  void onChange(Change<WeatherState> change) {
    super.onChange(change);
    log(change.toString());
  }
}
