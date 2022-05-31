
import 'package:dio/dio.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/software_model.dart';

class SoftwareAPIService {
  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.software);
  }

  static Future<Response> fetchSingle(int id) async {
    return await Dio().get(ApiPath.software + "/" + id.toString());
  }

  static Future<Response> create(SoftwareModel software) async {
    return await Dio().post(
      ApiPath.software,
      data: {'data': software.toJson()},
    );
  }

  static Future<Response> edit(SoftwareModel software, bool isChangedMaPhong) async {
    return await Dio().put(
      ApiPath.software + "/" + software.id.toString(),
      data: {'is_changed_ma_phong': isChangedMaPhong, 'data': software.toJson()},
    );
  }

  static Future<Response> delete(int id) async {
    return await Dio().delete(
      ApiPath.software + "/" + id.toString(),
    );
  }
}