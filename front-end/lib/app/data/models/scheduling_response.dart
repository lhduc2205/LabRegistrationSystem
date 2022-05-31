import 'package:lab_registration_management/app/data/models/timetable_model.dart';

class SchedulingResponse {
  SchedulingResponse({
    required this.timetableModel,
    required this.conflict,
  });

  final List<TimetableModel> timetableModel;
  final List<Conflict> conflict;

  factory SchedulingResponse.fromJson(Map<String, dynamic> json) => SchedulingResponse(
    timetableModel: List<TimetableModel>.from(json["timetable"].map((x) => TimetableModel.fromJson(x))),
    conflict: List<Conflict>.from(json["conflict"].map((x) => Conflict.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "timetable": List<dynamic>.from(timetableModel.map((x) => x.toJson())),
    "conflict": List<dynamic>.from(conflict.map((x) => x.toJson())),
  };
}

class Conflict {
  Conflict({
    required this.tuanId,
    required this.nhomThId,
  });

  final int tuanId;
  final int nhomThId;

  factory Conflict.fromJson(Map<String, dynamic> json) => Conflict(
    tuanId: json["tuan_id"],
    nhomThId: json["nhom_th_id"],
  );

  Map<String, dynamic> toJson() => {
    "tuan_id": tuanId,
    "nhom_th_id": nhomThId,
  };
}

