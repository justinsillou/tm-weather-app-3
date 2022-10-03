import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/models/weather_day.dart';
import 'package:weather_app_3/utils/utils.dart';

class DayWeatherWidget extends StatelessWidget {
  final WeatherDay weatherDay;

  const DayWeatherWidget({
    Key? key,
    required this.weatherDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<WeatherCubit>(context).select(weatherDay);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              buildRow(),
              if (DateFormat.yMd().format(DateTime.now()) ==
                  DateFormat.yMd().format(weatherDay.day))
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Chip(
                    label: Text("Aujourd'hui"),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      children: [
        Image.asset(
          Utils.weatherCodeToImage(weatherDay.weatherCode),
          height: 100,
        ),
        Expanded(
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                DateFormat.EEEE().add_d().format(weatherDay.day),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        Text(
          "${weatherDay.temperature2mMin}°C / ${weatherDay.temperature2mMax}°C",
        ),
      ],
    );
  }
}
