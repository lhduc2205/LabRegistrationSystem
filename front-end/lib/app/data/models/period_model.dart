class PeriodModel {
  PeriodModel({
    required this.id,
    required this.maBuoiHoc,
    required this.tenBuoiHoc,
  });

  final int id;
  final String maBuoiHoc;
  final String tenBuoiHoc;

  factory PeriodModel.fromJson(Map<String, dynamic> json) => PeriodModel(
    id: json["id"],
    maBuoiHoc: json["ma_buoi_hoc"],
    tenBuoiHoc: json["ten_buoi_hoc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ma_buoi_hoc": maBuoiHoc,
    "ten_buoi_hoc": tenBuoiHoc,
  };
}
