class WeekModel {
  WeekModel({
    required this.id,
    required this.maTuan,
    required this.tenTuan,
  });

  final int id;
  final int maTuan;
  final String tenTuan;

  factory WeekModel.fromJson(Map<String, dynamic> json) => WeekModel(
    id: json["id"],
    maTuan: json["ma_tuan"],
    tenTuan: json["ten_tuan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ma_tuan": maTuan,
    "ten_tuan": tenTuan,
  };
}
