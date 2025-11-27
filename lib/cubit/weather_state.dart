part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final List<Weather> weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
  Map<String, List<Weather>> get groupedWeather => groupWeatherByDay(weather);
}

final class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

final class WeatherOffline extends WeatherState {}

final class WeatherPermissionDenied extends WeatherState {}

final class WeatherPermissionDeniedForever extends WeatherState {}

final class WeatherLocationDisabled extends WeatherState {}
