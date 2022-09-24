import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_3/cubit/weather_data_cubit.dart';
import 'package:weather_app_3/models/weather_data.dart';
import 'package:weather_app_3/views/weather_widget.dart';

class HomeData extends StatelessWidget {
  const HomeData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherDataCubit(),
      child: BlocBuilder<WeatherDataCubit, WeatherData?>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('WeatherData Bloc'),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, WeatherData? weatherData) {
    if (weatherData == null) {
      return Center(
        child: ElevatedButton.icon(
          label: const Text('Fetch data'),
          icon: const Icon(Icons.refresh),
          onPressed: () => BlocProvider.of<WeatherDataCubit>(context).refresh(),
        ),
      );
    } else {
      return WeatherWidget(weatherData: weatherData);
    }
  }
}
