import 'package:intl/intl.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:dio/dio.dart';

class SemesterAPIService {

  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.semester);
  }

  static Future<Response> fetchByDate(DateTime dateTime) async {
    final date = DateFormat('MM-dd-yyyy').format(dateTime);
    return await Dio().get(ApiPath.semester + '/date/' + date + '/full');
  }
}
