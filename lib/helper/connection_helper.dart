import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionHelper {
  static Future<bool> hasWifiOrMobile() async {
    final Connectivity connectivity = Connectivity();
    List<ConnectivityResult> connectivityResult =
        await connectivity.checkConnectivity();
    if ((connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi))) {
      return true;
    }
    return false;
  }

  static Future<bool> hasNoConnection() async {
    final Connectivity connectivity = Connectivity();
    List<ConnectivityResult> connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return true;
    }
    return false;
  }
}
