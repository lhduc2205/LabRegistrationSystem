class DayModel {
  DayModel({
    required this.id,
    required this.maThu,
    required this.tenThu,
  });

  final int id;
  final String maThu;
  final String tenThu;

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
    id: json["id"],
    maThu: json["ma_thu"],
    tenThu: json["ten_thu"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ma_thu": maThu,
    "ten_thu": tenThu,
  };
}