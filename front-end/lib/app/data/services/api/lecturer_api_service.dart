import 'package:dio/dio.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/lecturer_model.dart';

class LecturerAPIService {

  static Future<Response> fetchLecturer() async {
    return await Dio().get(ApiPath.lecturers);
  }

  static Future<Response> fetchSingleLecturer(String email) async {
    return await Dio().get(ApiPath.lecturers + "/" + email);
  }

  static Future<Response> fetchFullInfoLecturer(String email) async {
    return await Dio().get(ApiPath.lecturers + '/$email' + "/full-info" );
  }

  static Future<Response> createLecturer(
      LecturerModel lecturer, String password) async {
    return await Dio().post(
      ApiPath.lecturers,
      data: {
        'data': lecturer.toJson(),
        'mat_khau': password
      },
    );
  }

  static Future<Response> updateLecturer(
      LecturerModel lecturer, bool isChangedMaGV) async {
    return await Dio().put(
      ApiPath.lecturers + "/" + lecturer.id.toString(),
      data: {
        'is_changed_ma_gv': isChangedMaGV,
        'data': lecturer.toJson()
      },
    );
  }

  static Future<Response> deleteLecturer(int id, String email) async {
    return await Dio().delete(
      ApiPath.lecturers + "/" + id.toString(),
      data: {"email": email},
    );
  }
}