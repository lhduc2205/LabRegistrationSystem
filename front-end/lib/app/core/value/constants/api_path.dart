part of app_constants;

class ApiPath {
  static const String base1 = "192.168.56.1:4000";
  static const String base2 = "http://192.168.56.1:4000";
  static const String baseUrl = "http://192.168.56.1:4000/api";

  static const String loginAPI = "$baseUrl/user/account/login";
  static const String lecturers = "$baseUrl/user";
  static const String departments = "$baseUrl/department";
  static const String labs = "$baseUrl/lab-software";
  static const String software = "$baseUrl/software";
  static const String course = "$baseUrl/course";
  static const String day = "$baseUrl/day";
  static const String period = "$baseUrl/period";
  static const String subject = "$baseUrl/subject";
  static const String subjectSoftware = "$baseUrl/subject-software";
  static const String week = "$baseUrl/week";
  static const String weekSemester = "$baseUrl/semester/detail";
  static const String semester = "$baseUrl/semester";
  static const String timetable = "$baseUrl/timetable";


}