import '../core/constants/styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result[0] == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText:
              Text('NO INTERNET CONNECTION !!', style: Constant.size14cW6),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          overlayBlur: 0.8,
          overlayColor: const Color.fromARGB(140, 0, 0, 0),
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 25,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      if (Get.isOverlaysOpen) {
        //Get.Over;
      }
    }
  }
}
