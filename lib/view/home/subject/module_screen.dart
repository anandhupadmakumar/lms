import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/controller/home/home_controller.dart';

import 'package:lms/view/home/splash/splash_screen.dart';
import 'package:lms/view/home/video_player/video_play_screen.dart';

import 'video_list_screen.dart';

class ModuleScreen extends StatelessWidget {
  ModuleScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Modules'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(homeController.modules.length, (index) {
              return Container(
                margin: EdgeInsets.only(top: 15.h),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20.0,
                  ),
                ]),
                child: ListTile(
                  tileColor: Colors.white,
                  onTap: () async {
                    await homeController
                        .fetchSubjectVideo(homeController.modules[index].id);

                    Get.to(() => VideoListScreen());
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.sp,
                  ),
                  title: CustomTextWidget(
                      text: homeController.modules[index].title,
                      textFontSize: 18.sp,
                      textFontWeight: FontWeight.bold,
                      textColor: Colors.black),
                  subtitle: CustomTextWidget(
                      text: homeController.modules[index].description,
                      textFontSize: 16.sp,
                      textFontWeight: FontWeight.w400,
                      textColor: Colors.black),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
