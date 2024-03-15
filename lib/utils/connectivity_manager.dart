import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager {
  Future<bool> hasInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
