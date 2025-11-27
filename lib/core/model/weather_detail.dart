import 'package:flutter/material.dart';

class WeatherDetail {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}
