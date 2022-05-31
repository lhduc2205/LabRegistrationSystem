// import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
// import 'package:lab_registration_management/app/data/models/department_model.dart';
// import 'package:lab_registration_management/app/data/services/api_request.dart';
//
// class DepartmentProvider {
//
//   void getDepartmentList({
//     Function()? beforeSend,
//     required Function(List<DepartmentModel> departments) onSuccess,
//     required Function(dynamic error)? onError,
//   }) {
//     ApiRequest(url: ApiPath.getAllDepartment, data: null).get(
//       beforeSend: () => {if (beforeSend != null) beforeSend()},
//       onSuccess: (data) {
//         onSuccess(
//           (data as List)
//               .map(
//                 (departmentJson) {
//                   return DepartmentModel.fromJson(departmentJson);
//                 }
//               )
//               .toList(),
//         );
//       },
//       onError: (error) => {if (onError != null) onError(error)},
//     );
//   }
//
//   void createDepartment({
//     Function()? beforeSend,
//     required Function(List<DepartmentModel> departments) onSuccess,
//     required Function(dynamic error)? onError,
//     required Map<String, dynamic> data
//   }) {
//     ApiRequest(url: ApiPath.de, data: null).post(
//       beforeSend: () => {if (beforeSend != null) beforeSend()},
//       departmentData: data,
//       onSuccess: (data) {
//         onSuccess(
//           (data as List)
//               .map(
//                   (departmentJson) {
//                 return DepartmentModel.fromJson(departmentJson);
//               }
//           )
//               .toList(),
//         );
//       },
//       onError: (error) => {if (onError != null) onError(error)},
//     );
//   }
//
// }
