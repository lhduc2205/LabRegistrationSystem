import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:dio/dio.dart';

class SubjectAPIService {

  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.subject);
  }

  static Future<Response> fetchSubjectSoftware() async {
    return await Dio().get(ApiPath.subjectSoftware);
  }
}
