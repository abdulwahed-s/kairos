import 'package:flutter/material.dart';

class DayWeatherView extends StatelessWidget {
  final List<dynamic> dayWeather;
  final Widget Function(dynamic weather) mainWeatherCardBuilder;
  final Widget Function(dynamic weather) weatherDetailsGridBuilder;
  final Widget Function(List<dynamic> dayWeather) hourlyForecastBuilder;

  const DayWeatherView({
    super.key,
    required this.dayWeather,
    required this.mainWeatherCardBuilder,
    required this.weatherDetailsGridBuilder,
    required this.hourlyForecastBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 75),
          mainWeatherCardBuilder(dayWeather[0]),
          const SizedBox(height: 24),
          weatherDetailsGridBuilder(dayWeather[0]),
          const SizedBox(height: 24),
          hourlyForecastBuilder(dayWeather),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}