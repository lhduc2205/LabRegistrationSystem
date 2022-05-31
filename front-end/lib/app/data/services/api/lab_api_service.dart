import 'package:dio/dio.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/lab_model.dart';

class LabAPIService {
  static Future<Response> fetchLab() async {
    return await Dio().get(ApiPath.labs);
  }

  static Future<Response> fetchSingle(int id) async {
    return await Dio().get(ApiPath.labs + "/" + id.toString());
  }

  static Future<Response> createLab(LabModel lab) async {
    return await Dio().post(
      ApiPath.labs,
      data: lab.toJson(),
    );
  }

  static Future<Response> editLab(LabModel lab) async {
    return await Dio().put(
      ApiPath.labs + "/" + lab.id.toString(),
      data: lab.toJson(),
    );
  }

  static Future<Response> deleteLab(int id) async {
    return await Dio().delete(
      ApiPath.labs + "/" + id.toString(),
    );
  }
}
