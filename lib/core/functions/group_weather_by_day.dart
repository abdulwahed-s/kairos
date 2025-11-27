import 'package:weather/weather.dart';

Map<String, List<Weather>> groupWeatherByDay(List<Weather> weatherList) {
  Map<String, List<Weather>> grouped = {};

  for (var w in weatherList) {
    String dayKey = DateTime(w.date!.year, w.date!.month, w.date!.day).toString();
    if (!grouped.containsKey(dayKey)) {
      grouped[dayKey] = [];
    }
    grouped[dayKey]!.add(w);
  }

  return grouped;
}
