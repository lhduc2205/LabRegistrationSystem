
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class ExcelService {
  static Future pickExcelFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );
    return picked;
  }

  static FormData convertToFormData(FilePickerResult result, String fieldText) {
    PlatformFile file = result.files.first;
    String fileName = file.name;
    FormData formData = FormData.fromMap({
      fieldText: MultipartFile.fromBytes(List.from(file.bytes!), filename: fileName),
    });
    return formData;
  }
}