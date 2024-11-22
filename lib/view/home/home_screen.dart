import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../../controller/home/home_controller.dart';
import 'splash/splash_screen.dart';
import 'subject/module_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.fetchSubjects();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(180.w, 180.w),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(20.r)),
            child: Row(
              children: [
                Lottie.asset('assets/images/Animation - 1732173373601.json'),
                CustomTextWidget(
                    text: 'Good Morning...',
                    textFontSize: 20.sp,
                    textFontWeight: FontWeight.bold,
                    textColor: Colors.black)
              ],
            ),
          )),
      body: Container(
        child: GetBuilder<HomeController>(
            id: 'subject_id',
            builder: (subjectData) {
              return GridView.builder(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w, vertical: 20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.w),
                itemCount: subjectData.subjects.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await homeController
                          .fetchSubjectModules(subjectData.subjects[index].id);
                      Get.to(() => ModuleScreen());
                    },
                    child: Container(
                      height: 150.h,
                      width: 160.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.w)),
                      child: CachedNetworkImage(
                        height: 150.h,
                        width: 160.w,
                        imageUrl: subjectData.subjects[index].imageUrl,
                        placeholder: (context, url) => Center(
                            child: Lottie.asset(
                                'assets/images/Animation - 1732175132056.json')),
                        errorWidget: (context, url, error) => const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image,
                                color: Colors.grey, size: 50),
                            Text('Failed to load image',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
