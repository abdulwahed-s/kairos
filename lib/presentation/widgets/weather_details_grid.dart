import 'package:flutter/material.dart';
import 'package:kairos/core/model/weather_detail.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final dynamic weather;

  const WeatherDetailsGrid({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final details = [
      WeatherDetail(
        icon: Icons.water_drop_rounded,
        label: 'Humidity',
        value: '${weather.humidity ?? '--'}%',
        color: const Color(0xFF74b9ff),
      ),
      WeatherDetail(
        icon: Icons.cloud_rounded,
        label: 'Cloudiness',
        value: '${weather.cloudiness ?? '--'}%',
        color: const Color(0xFF95a5a6),
      ),
      WeatherDetail(
        icon: Icons.compress_rounded,
        label: 'Pressure',
        value: '${weather.pressure ?? '--'} hPa',
        color: const Color(0xFFe17055),
      ),
      WeatherDetail(
        icon: Icons.air_rounded,
        label: 'Wind Speed',
        value: '${weather.windSpeed ?? '--'} m/s',
        color: const Color(0xFF00b894),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: details.length,
      itemBuilder: (context, index) {
        final detail = details[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: detail.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(detail.icon, color: detail.color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                detail.label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              Text(
                detail.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
