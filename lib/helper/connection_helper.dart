import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionHelper {
  static Future<bool> hasWifiOrMobile() async {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if ((connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  static Future<bool> hasNoConnection() async {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return true;
    }
    return false;
  }
}
