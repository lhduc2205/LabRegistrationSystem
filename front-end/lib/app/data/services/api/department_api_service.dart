import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/department_model.dart';
import 'package:dio/dio.dart';

class DepartmentAPIService {

  static Future<Response> fetchDepartment() async {
    return await Dio().get(ApiPath.departments);
  }

  static Future<Response> getSingleDepartment(int id) async {
    return await Dio().get(ApiPath.departments + "/" + id.toString());
  }

  static Future<Response> createDepartment(
      DepartmentRequestModel department) async {
    return await Dio().post(
      ApiPath.departments,
      data: department.toJson(),
    );
  }

  static Future<Response> updateDepartment(
      DepartmentModel department) async {
    return await Dio().put(
      ApiPath.departments + "/" + department.id.toString(),
      data: department.toJson(),
    );
  }

  static Future<Response> deleteDepartment(int id) async {
    return await Dio().delete(
      ApiPath.departments + "/" + id.toString(),
      data: {"id": id},
    );
  }
}
