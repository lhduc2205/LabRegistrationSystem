import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:lab_registration_management/app/modules/info/controllers/info_controller.dart';

const rootRoute = "/";

// Display name in side bar
const labCalendarPageDisplayName = "Thực hành";
const authenticationPageDisplayName = "Authentication";
const departmentPageDisplayName = "Bộ môn";
const lecturerPageDisplayName = "Giảng viên";
const labPageDisplayName = "Phòng thực hành";
const teachingPageDisplayName = "Giảng dạy";
const labRegistrationPageDisplayName = "Đăng kí";
const infoPageDisplayName = "Thông tin cá nhân";
const timetablePageDisplayName = "Lịch thực hành";
const timetableClonePageDisplayName = "Lịch mẫu";
const myTimetablePageDisplayName = "Lịch của tôi";
const subjectPageDisplayName = "Môn học";

// Define route
const labCalendarPageRoute = "/lich-thuc-hanh";
const authenticationPageRoute = "/auth";
const departmentPageRoute = "/department";
const lecturerPageRoute = "/lecturer";
const labPageRoute = "/lab";
const loginPageRoute = '/dang-nhap';
const teachingPageRoute = "/giang-day";
const labRegistrationPageRoute = "/lich-dang-ky";
const infoPageRoute = "/thong-tin-ca-nhan";
const timeTablePageRoute = "/lich-thuc-hanh";
const timetableClonePageRoute = "/lich-th-mau";
const myTimetablePageRoute = "/lich-cua-toi";
const subjectPageRoute = "/mon-hoc";

// final role = Get.find<InfoController>().lecturerInfo?.maVaiTro;

final box = GetStorage();
final email = box.read(BoxString.EMAIL);

class MenuItem {
  final String name;
  final String route;

  MenuItem({required this.name, required this.route});
}

List<MenuItem> itemRoutesInCalendarPanel = [
  MenuItem(
    name: timetablePageDisplayName,
    route: timeTablePageRoute,
  ),
  MenuItem(
    name: teachingPageDisplayName,
    route: teachingPageRoute,
  ),
  MenuItem(
    name: labRegistrationPageDisplayName,
    route: labRegistrationPageRoute,
  ),
];

List<MenuItem> itemRoutesInCategoryPanel = [
  MenuItem(
    name: departmentPageDisplayName,
    route: departmentPageRoute,
  ),
  MenuItem(
    name: lecturerPageDisplayName,
    route: lecturerPageRoute,
  ),
  MenuItem(
    name: labPageDisplayName,
    route: labPageRoute,
  ),
  MenuItem(
    name: subjectPageDisplayName,
    route: subjectPageRoute,
  )
];

List<MenuItem> itemRoutesInInfoPanel = [
  MenuItem(
    name: infoPageDisplayName,
    route: infoPageRoute,
  ),
];
