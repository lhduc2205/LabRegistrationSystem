import 'dart:convert';

LabModel labModelFromJson(String str) => LabModel.fromJson(json.decode(str));

String labModelToJson(LabModel data) => json.encode(data.toJson());

class LabModel {
  LabModel({
    this.id,
    required this.tenPhong,
    required this.soChoNgoi,
    required this.dungLuongRam,
    required this.dungLuongOCung,
    required this.cpu,
    required this.gpu,
    required this.boMonId,
    required this.phanMemId,
  });

  final int? id;
  final String tenPhong;
  final int soChoNgoi;
  final int dungLuongRam;
  final int dungLuongOCung;
  final String cpu;
  final String gpu;
  final int boMonId;
  final List phanMemId;

  factory LabModel.fromJson(Map<String, dynamic> json) => LabModel(
    id: json["id"],
    tenPhong: json["ten_phong"],
    soChoNgoi: json["so_cho_ngoi"],
    dungLuongRam: json["dung_luong_ram"],
    dungLuongOCung: json["dung_luong_o_cung"],
    cpu: json["cpu"],
    gpu: json["gpu"],
    boMonId: json["bo_mon_id"],
    phanMemId: json["phan_mem_id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten_phong": tenPhong,
    "so_cho_ngoi": soChoNgoi,
    "dung_luong_ram": dungLuongRam,
    "dung_luong_o_cung": dungLuongOCung,
    "cpu": cpu,
    "gpu": gpu,
    "bo_mon_id": boMonId,
    "phan_mem_id": phanMemId,
  };

  @override
  String toString() {
    return '''
    "id": $id,
    "ten_phong": $tenPhong,
    "so_cho_ngoi": $soChoNgoi,
    "dung_luong_ram": $dungLuongRam,
    "dung_luong_o_cung": $dungLuongOCung,
    "cpu": $cpu,
    "gpu": $gpu,
    "bo_mon_id": $boMonId,
    "phan_mem_id": $phanMemId,
    ''';
  }
}
