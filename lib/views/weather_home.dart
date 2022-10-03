import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/utils/utils.dart';
import 'package:weather_app_3/views/day_weather_widget.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(),
        ),
      ],
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          var buttons = [
            TextButton(
              onPressed: () {
                BlocProvider.of<WeatherCubit>(context).refresh();
              },
              child: const Center(child: Text("Refresh")),
            )
          ];

          if (state is WeatherSelectedState) {
            buttons.add(
              TextButton(
                onPressed: () {
                  BlocProvider.of<WeatherCubit>(context).unselect();
                },
                child: const Center(child: Text("Unselect")),
              ),
            );
          }

          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: _buildBody(context, state),
            ),
            backgroundColor: Colors.white,
            persistentFooterButtons: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons.map((e) => Expanded(child: e)).toList(),
              )
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Météo'),
    );
  }

  Widget _buildBody(BuildContext context, WeatherState state) {
    if (state is WeatherLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is WeatherLoadedState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.weatherData.daily.time.length,
                itemBuilder: (context, index) => DayWeatherWidget(
                  weatherDay:
                      state.weatherData.daily.getDayByIndex(index: index),
                ),
              ),
            ),
            const Divider(),
            ...buildSelectedDayWidgets(context, state),
          ],
        ),
      );
    } else {
      return Center(
        child: ElevatedButton(
          onPressed: () => BlocProvider.of<WeatherCubit>(context).refresh(),
          child: const Text("Charger la météo"),
        ),
      );
    }
  }

  List<Widget> buildSelectedDayWidgets(
      BuildContext context, WeatherLoadedState state) {
    if (state is WeatherSelectedState) {
      return [
        Text(
          DateFormat.yMMMMEEEEd().format(state.weatherDay.day),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Expanded(
          child: Image.asset(
            Utils.weatherCodeToImage(state.weatherDay.weatherCode),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Min: ${state.weatherDay.temperature2mMin}°C",
            ),
            Text(
              "Max: ${state.weatherDay.temperature2mMax}°C",
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sunrise: ${DateFormat.Hms().format(state.weatherDay.sunrise)}",
            ),
            Text(
              "Sunset: ${DateFormat.Hms().format(state.weatherDay.sunset)}",
            ),
          ],
        )
      ];
    }

    return [];
  }
}
