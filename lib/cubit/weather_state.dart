part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherData weatherData;

  WeatherLoadedState({required this.weatherData});
}

class WeatherSelectedState extends WeatherLoadedState {
  final WeatherDay weatherDay;

  WeatherSelectedState(
      {required WeatherData weatherData, required this.weatherDay})
      : super(weatherData: weatherData);
}
