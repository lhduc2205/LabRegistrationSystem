
class SoftwareModel {
  SoftwareModel({
    required this.id,
    required this.maPhanMem,
    required this.tenPhanMem,
    required this.phienBan,
  });

  final int id;
  final String maPhanMem;
  final String tenPhanMem;
  final String phienBan;

  factory SoftwareModel.fromJson(Map<String, dynamic> json) => SoftwareModel(
    id: json["id"],
    maPhanMem: json["ma_phan_mem"],
    tenPhanMem: json["ten_phan_mem"],
    phienBan: json["phien_ban"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ma_phan_mem": maPhanMem,
    "ten_phan_mem": tenPhanMem,
    "phien_ban": phienBan,
  };
}
