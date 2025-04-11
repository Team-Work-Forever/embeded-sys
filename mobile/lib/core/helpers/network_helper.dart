import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

final class NetWorkHelper {
  static const Duration timeOut = Duration(minutes: 1);

  Future<bool> _hasInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.any((cr) => cr != ConnectivityResult.none);
  }

  Future<bool> canUseNetwork() {
    return _hasInternet();
  }
}
