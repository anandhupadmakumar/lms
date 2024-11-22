import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lms/model/course_model.dart';
import 'package:lms/view/loader.dart';

import '../../model/subject_model.dart';
import '../../model/video_item.dart';

class HomeController extends GetxController {
  RxInt timerValue = 5.obs;

  var subjects = <Subject>[].obs;

  var modules = <Module>[].obs;

  var videoList = <VideoItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchSubjects() async {
    try {
      errorMessage('');

      await Dio()
          .post('https://trogon.info/interview/php/api/subjects.php',
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ))
          .then((value) {
        if (value.statusCode == 200) {
          List<dynamic> data = jsonDecode(value.data.toString());
          subjects.value = data.map((json) => Subject.fromJson(json)).toList();
          print('api image   ${subjects[0].imageUrl}');
        } else {
          errorMessage('Failed to load subjects');
        }
      });
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
    update(['subject_id']);
  }

  Future<void> fetchSubjectModules(subjectId) async {
    try {
      isLoading(true);
      Loader.showLoader();
      errorMessage('');

      await Dio()
          .post(
              'https://trogon.info/interview/php/api/modules.php?subject_id=$subjectId',
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ))
          .then((value) {
        if (value.statusCode == 200) {
          List<dynamic> data = jsonDecode(value.data.toString());
          modules.value = data.map((json) => Module.fromJson(json)).toList();
        } else {
          errorMessage('Failed to load subjects');
        }
      });
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      Loader.stopLoader();
      isLoading(false);
    }
    update();
  }

  Future<void> fetchSubjectVideo(moduleVideoSubjectId) async {
    try {
      isLoading(true);
      Loader.showLoader();
      errorMessage('');

      await Dio()
          .post(
              'https://trogon.info/interview/php/api/videos.php?module_id=$moduleVideoSubjectId',
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ))
          .then((value) {
        if (value.statusCode == 200) {
          List<dynamic> data = jsonDecode(value.data.toString());
          videoList.value =
              data.map((json) => VideoItem.fromJson(json)).toList();
        } else {
          errorMessage('Failed to load subjects');
        }
      });
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      Loader.stopLoader();
      isLoading(false);
    }
    update();
  }
}
