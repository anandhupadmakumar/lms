import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Loader {
  static showLoader() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white,
        context: Get.context!,
        builder: (ctx) =>
            Lottie.asset('assets/images/Animation - 1732175132056.json'));
  }

  static stopLoader() {
    Get.back();
  }
}
