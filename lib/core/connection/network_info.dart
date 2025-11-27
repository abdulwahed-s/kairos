import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static Future<bool> checkInternetConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      return false; 
    }
  }
}
