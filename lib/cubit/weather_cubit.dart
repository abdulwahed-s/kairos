import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kairos/core/connection/network_info.dart';
import 'package:kairos/core/functions/group_weather_by_day.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(WeatherLocationDisabled());
      return null; 
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(WeatherPermissionDenied());
        return null; 
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(WeatherPermissionDeniedForever());
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    if (await NetworkInfo.checkInternetConnectivity()) {
      try {
        Position? position = await determinePosition();
        if (position == null) return;

        WeatherFactory wf = WeatherFactory("e4011c042edeba6a8204155fd3e84621");
        List<Weather> weather = await wf.fiveDayForecastByLocation(
          position.latitude,
          position.longitude,
        );
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    } else {
      emit(WeatherOffline());
    }
  }
}
