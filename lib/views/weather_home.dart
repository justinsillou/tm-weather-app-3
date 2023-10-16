import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/models/weather/weather_day.dart';
import 'package:weather_app_3/views/day_weather_widget.dart';
import 'package:weather_app_3/views/loading_widget.dart';
import 'package:weather_app_3/views/selected_day_widget.dart';
import 'package:weather_app_3/views/weather_home_v1.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
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
      title: const Text('Météo V2'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const WeatherHomeV1(),
              ),
            );
          },
          icon: const Icon(Icons.swap_horiz),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WeatherState state) {
    if (state is WeatherLoadingState) {
      return const LoadingWidget();
    }

    if (state is WeatherLoadedState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.weatherData.daily.time.length,
                itemBuilder: (context, index) {
                  WeatherDay weatherDay = state.weatherData.daily.getDayByIndex(index: index);
                  return DayWeatherWidget(
                    weatherDay: weatherDay,
                    selected: state is WeatherSelectedState ? state.weatherDay == weatherDay : false,
                    interactive: true,
                  );
                },
              ),
            ),
            const Divider(),
            buildSelectedDayWidget(context, state),
          ],
        ),
      );
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<WeatherCubit>().refresh();
        },
        child: const Text("Charger la météo"),
      ),
    );
  }

  Widget buildSelectedDayWidget(BuildContext context, WeatherLoadedState state) {
    if (state is WeatherSelectedState) {
      return SelectedDayWidget(day: state.weatherDay);
    }

    return const Center(child: Text("Aucun jour sélectionné"));
  }
}
