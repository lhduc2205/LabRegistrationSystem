class DepartmentModel {
  DepartmentModel({
    required this.id,
    required this.tenBoMon,
    required this.vietTat,
  });

  final int id;
  final String tenBoMon;
  final String vietTat;

  // factory BoMon.fromRawJson(String str) => BoMon.fromJson(json.decode(str));
  // String toRawJson() => json.encode(toJson());

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json["id"],
        tenBoMon: json["ten_bo_mon"],
        vietTat: json["viet_tat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ten_bo_mon": tenBoMon,
        "viet_tat": vietTat,
      };
}

class DepartmentRequestModel {
  final String tenBoMon;
  final String vietTat;

  DepartmentRequestModel({required this.tenBoMon, required this.vietTat});

  factory DepartmentRequestModel.fromJson(Map<String, dynamic> json) =>
      DepartmentRequestModel(
        tenBoMon: json["ten_bo_mon"],
        vietTat: json["viet_tat"],
      );

  Map<String, dynamic> toJson() => {
        "ten_bo_mon": tenBoMon,
        "viet_tat": vietTat,
      };
}
