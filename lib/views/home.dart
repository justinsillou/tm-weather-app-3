import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/views/loading_widget.dart';
import 'package:weather_app_3/views/weather_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Weather Bloc'),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, WeatherState state) {
    if (state is WeatherLoading) {
      return const LoadingWidget();
    } else if (state is WeatherLoaded) {
      return WeatherWidget(weatherData: state.weatherData);
    } else {
      return Center(
        child: ElevatedButton.icon(
          label: const Text('Fetch data'),
          icon: const Icon(Icons.refresh),
          onPressed: () => BlocProvider.of<WeatherCubit>(context).refresh(),
        ),
      );
    }
  }
}
