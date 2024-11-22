import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/controller/home/home_controller.dart';

import '../home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      homeController.timerValue.value--;

      if (homeController.timerValue.value == 0) {
        timer.cancel();
        Get.off(() => HomeScreen());
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset(
              fit: BoxFit.cover,
              'assets/images/Group 2103.png',
              width: Get.width,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextWidget(
                text: 'Welcome to LMS',
                textFontSize: 20.sp,
                textFontWeight: FontWeight.bold,
                textColor: Colors.black),
            SizedBox(
              height: 15.h,
            ),
            CustomTextWidget(
                align: TextAlign.center,
                text:
                    'A Learning Management System (LMS) study app displays subjects on the home screen and provides module videos for effective learning.',
                textFontSize: 14.sp,
                textFontWeight: FontWeight.w400,
                textColor: Colors.black),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: EdgeInsets.all(15),
        child: InkWell(
          onTap: () {
            Get.off(() => HomeScreen());
          },
          child: Container(
            width: 334.w,
            height: 54.h,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                    text: 'Get Started',
                    textFontSize: 16.sp,
                    textFontWeight: FontWeight.bold,
                    textColor: Colors.white),
                SizedBox(
                  width: 5.w,
                ),
                Obx(
                  () => CustomTextWidget(
                      text: '(${homeController.timerValue.value}s)',
                      textFontSize: 16.sp,
                      textFontWeight: FontWeight.bold,
                      textColor: Colors.white),
                ),
                SizedBox(
                  width: 70.w,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {super.key,
      required this.text,
      required this.textFontSize,
      required this.textFontWeight,
      required this.textColor,
      this.align = TextAlign.start});

  final String text;
  final double textFontSize;
  final FontWeight textFontWeight;
  final Color textColor;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: textColor, fontSize: textFontSize, fontWeight: textFontWeight),
    );
  }
}
