import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:dio/dio.dart';

class PeriodAPIService {

  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.period);
  }
}
