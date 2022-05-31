import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/course_model.dart';

class CourseAPIService {
  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.course);
  }

  static Future<Response> fetchSingle(int id) async {
    return await Dio().get(ApiPath.course + "/" + id.toString());
  }

  static Future<Response> fetchByLecturer(String email) async {
    return await Dio().get(ApiPath.course + "/lecturer/" + email.toString());
  }

  static Future<Response> create(CourseModel course) async {
    return await Dio().post(
      ApiPath.course,
      data: {'data': course.toJson()},
    );
  }
  //
  // static Future<Response> edit(TeachingModel course, bool isChangedMaPhong) async {
  //   return await Dio().put(
  //     ApiPath.course + "/" + course.id.toString(),
  //     data: {'is_changed_ma_phong': isChangedMaPhong, 'data': course.toJson()},
  //   );
  // }
  //
  // static Future<Response> delete(int id) async {
  //   return await Dio().delete(
  //     ApiPath.course + "/" + id.toString(),
  //   );
  // }

  static Future<Response> uploadFile(FilePickerResult result) async {
    PlatformFile file = result.files.first;
    String fileName = file.name;
    FormData formData = FormData.fromMap({
      "course": MultipartFile.fromBytes(List.from(file.bytes!), filename: fileName),
    });
    return await Dio().post(ApiPath.course + '/upload', data: formData);
  }

  static Future<Response> downloadFile(String email) async {
    return await Dio().get(ApiPath.course + "/download/" + email.toString());
  }
}