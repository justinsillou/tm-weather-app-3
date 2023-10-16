import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_3/cubit/weather_cubit.dart';
import 'package:weather_app_3/models/weather/weather_day.dart';
import 'package:weather_app_3/utils/utils.dart';
import 'package:weather_icons/weather_icons.dart';

class DayWeatherWidget extends StatelessWidget {
  final WeatherDay weatherDay;
  final bool selected;
  final bool interactive;

  const DayWeatherWidget({
    Key? key,
    required this.weatherDay,
    this.selected = false,
    this.interactive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: interactive
          ? () {
              BlocProvider.of<WeatherCubit>(context).select(weatherDay);
            }
          : null,
      child: Card(
        color: selected ? Theme.of(context).primaryColorLight : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildRow(),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      children: [
        BoxedIcon(
          Utils.weatherCodeToIcon(weatherDay.weatherCode),
        ),
        // Image.asset(
        //   Utils.weatherCodeToImage(weatherDay.weatherCode),
        //   height: 100,
        // ),
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
              if (DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().format(weatherDay.day)) ...{
                const Icon(
                  Icons.today,
                  size: 16,
                ),
              }
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
