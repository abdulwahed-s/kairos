import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kairos/cubit/weather_cubit.dart';
import 'package:kairos/presentation/widgets/weather_tab_bar.dart';
import 'package:kairos/presentation/widgets/day_weather_view.dart';
import 'package:kairos/presentation/widgets/main_weather_card.dart';
import 'package:kairos/presentation/widgets/weather_details_grid.dart';
import 'package:kairos/presentation/widgets/hourly_forecast.dart';

class WeatherContent extends StatelessWidget {
  final dynamic state;
  final TabController tabController;
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;

  const WeatherContent({
    super.key,
    required this.state,
    required this.tabController,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = state.groupedWeather;
    final dayKeys = grouped.keys.toList();

    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Stack(
              children: [
                _buildTabBarView(dayKeys, grouped),
                _buildTopBar(context, dayKeys),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBarView(
    List<String> dayKeys,
    Map<String, List<dynamic>> grouped,
  ) {
    return Positioned.fill(
      child: TabBarView(
        controller: tabController,
        children: dayKeys.map((dayKey) {
          final dayWeather = grouped[dayKey]!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: DayWeatherView(
              dayWeather: dayWeather,
              mainWeatherCardBuilder: (weather) =>
                  MainWeatherCard(weather: weather),
              weatherDetailsGridBuilder: (weather) =>
                  WeatherDetailsGrid(weather: weather),
              hourlyForecastBuilder: (dayWeather) =>
                  HourlyForecast(dayWeather: dayWeather),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, List<String> dayKeys) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(flex: 5, child: _buildTabBar(dayKeys)),
            const SizedBox(width: 8),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: AnimatedBuilder(
                    animation: fadeAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: fadeAnimation.value,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withValues(alpha: 0.2),
                                      Colors.white.withValues(alpha: 0.05),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(-1, -1),
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    context.read<WeatherCubit>().fetchWeather();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(List<String> dayKeys) {
    return WeatherTabBar(tabController: tabController, dayKeys: dayKeys);
  }
}
