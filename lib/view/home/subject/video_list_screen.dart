import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/controller/home/home_controller.dart';
import 'package:lms/view/home/splash/splash_screen.dart';
import 'package:lms/view/home/video_player/video_play_screen.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListScreen extends StatelessWidget {
  VideoListScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Videos'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(homeController.videoList.length, (index) {
              return Container(
                margin: EdgeInsets.only(top: 15.h),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20.0,
                  ),
                ]),
                child: ListTile(
                  onTap: () {
                    Get.to(() => VideoPlayerScreen(
                        video: homeController.videoList[index]));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.sp,
                  ),
                  leading: Stack(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Center(
                          child: homeController.videoList[index].videoType ==
                                  'YouTube'
                              ? YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId:
                                        YoutubePlayer.convertUrlToId(
                                                homeController.videoList[index]
                                                    .videoUrl) ??
                                            '',
                                    flags: YoutubePlayerFlags(autoPlay: false),
                                  ),
                                )
                              : VimeoPlayer(
                                  videoId: '222018604',
                                ),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => VideoPlayerScreen(
                                video: homeController.videoList[index]));
                          },
                          child: SizedBox(
                            width: 100.w,
                            height: 100.h,
                          ))
                    ],
                  ),
                  title: CustomTextWidget(
                      text: homeController.videoList[index].title,
                      textFontSize: 16.sp,
                      textFontWeight: FontWeight.w800,
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
