

import 'package:dio/dio.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class WeekSemesterAPIService {
  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.weekSemester);
  }
}