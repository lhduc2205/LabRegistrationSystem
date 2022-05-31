import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/data/models/timetable_model.dart';
import 'package:lab_registration_management/app/data/services/excel_service.dart';

class TimetableAPIService {
  static Future<Response> fetch() async {
    return await Dio().get(ApiPath.timetable);
  }

  static Future<Response> fetchClone() async {
    return await Dio().get(ApiPath.timetable + '/clone');
  }

  static Future<Response> fetchSingle(int id) async {
    return await Dio().get(ApiPath.timetable + "/" + id.toString());
  }

  static Future<Response> fetchByLecturer(String email) async {
    return await Dio().get(ApiPath.timetable + "/lecturer/" + email.toString());
  }

  static Future<Response> fetchGroupByLecturer(String email) async {
    return await Dio()
        .get(ApiPath.timetable + "/group/lecturer/" + email.toString());
  }

  static Future<Response> fetchRegistration() async {
    return await Dio().get(ApiPath.timetable + "/registration");
  }

  static Future<Response> fetchRegistrationNoFormat() async {
    return await Dio().get(ApiPath.timetable + "/registration/no-format");
  }

  static Future<Response> fetchRegistrationByEmail(String email) async {
    return await Dio()
        .get(ApiPath.timetable + "/registration/" + email.toString());
  }

  static Future<Response> downloadFile(String email) async {
    return await Dio().get(ApiPath.timetable + "/download/" + email.toString());
  }

  static Future<Response> scheduling() async {
    return await Dio().get(ApiPath.timetable + "/scheduling");
  }

  static Future<Response> saveClone() async {
    return await Dio().get(ApiPath.timetable + "/clone/save");
  }

  static Future<Response> checkAvailableRoom(Map<String, dynamic> data) async {
    return await Dio()
        .post(ApiPath.timetable + '/check-available-room', data: data);
  }

  static Future<Response> createTimetableWithDraggable(Map<String, dynamic> data) async {
    return await Dio()
        .post(ApiPath.timetable + '/create', data: data);
  }

  static Future<Response> uploadFile(FilePickerResult result) async {
    FormData formData = ExcelService.convertToFormData(result, 'timetable');
    return await Dio().post(ApiPath.timetable + '/upload', data: formData);
  }

  static Future<Response> updateTimetable(TimetableModel timetable) async {
    return await Dio().put(ApiPath.timetable + '/update', data: timetable);
  }

  static Future<Response> updateTimetableWithDraggable(
      Map<String, dynamic> source, Map<String, dynamic> des) async {
    return await Dio().put(
      ApiPath.timetable + '/update/draggable',
      data: {
        "source": {
          "phong_id": source['phong_id'],
          "thu_id": source['thu_id'],
          "tuan_id": source['tuan_id'],
          "buoi_hoc_id": source['buoi_hoc_id'],
        },
        "des": {
          "phong_id": des['phong_id'],
          "thu_id": des['thu_id'],
          "tuan_id": des['tuan_id'],
          "buoi_hoc_id": des['buoi_hoc_id'],
        }
      },
    );
  }

  static Future<Response> updateClone(
      Map<String, dynamic> source, Map<String, dynamic> des) async {
    return await Dio().put(
      ApiPath.timetable + '/clone/update',
      data: {
        "source": {
          "phong_id": source['phong_id'],
          "thu_id": source['thu_id'],
          "tuan_id": source['tuan_id'],
          "buoi_hoc_id": source['buoi_hoc_id'],
        },
        "des": {
          "phong_id": des['phong_id'],
          "thu_id": des['thu_id'],
          "tuan_id": des['tuan_id'],
          "buoi_hoc_id": des['buoi_hoc_id'],
        }
      },
    );
  }

  static Future<Response> register(List<int> weekList, int groupID) async {
    return await Dio().post(
      ApiPath.timetable + '/registration',
      data: {'ma_nhom': groupID, 'tuan_th': weekList},
    );
  }
}
