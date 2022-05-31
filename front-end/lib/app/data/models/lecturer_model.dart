import 'dart:convert';

import 'dart:convert';

import 'package:intl/intl.dart';

LecturerModel lecturerModelFromJson(String str) =>
    LecturerModel.fromJson(json.decode(str));

String lecturerModelToJson(LecturerModel data) => json.encode(data.toJson());

class LecturerModel {
  LecturerModel({
    required this.id,
    required this.maGv,
    required this.hoTen,
    required this.gioiTinh,
    required this.ngaySinh,
    required this.sdt,
    required this.boMonId,
    required this.emailGV,
    this.tenVaiTro,
    this.maVaiTro,
    this.tenBoMon,
  });

  final int? id;
  final String maGv;
  final String hoTen;
  final bool gioiTinh;
  final DateTime ngaySinh;
  final String sdt;
  final int boMonId;
  final String emailGV;
  final String? tenVaiTro;
  final String? maVaiTro;
  String? tenBoMon;

  factory LecturerModel.fromJson(Map<String, dynamic> json) => LecturerModel(
        id: json["id"],
        maGv: json["ma_gv"],
        hoTen: json["ho_ten"],
        gioiTinh: json["gioi_tinh"],
        ngaySinh: DateTime.parse(json["ngay_sinh"]),
        sdt: json["sdt"],
        boMonId: json["bo_mon_id"],
        emailGV: json["email_gv"],
        tenVaiTro: json["ten_vai_tro"],
        maVaiTro: json["ma_vai_tro"],
        tenBoMon: json["ten_bo_mon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ma_gv": maGv,
        "ho_ten": hoTen,
        "gioi_tinh": gioiTinh,
        "ngay_sinh": DateFormat('MM-dd-yyyy').format(ngaySinh),
        "sdt": sdt,
        "bo_mon_id": boMonId,
        "email_gv": emailGV,
        "ten_vai_tro": tenVaiTro,
        "ma_vai_tro": maVaiTro,
        "ten_bo_mon": tenBoMon,
      };

  String toString() {
    return '''
      id: $id,
      "ma_gv": $maGv,
      "ho_ten": $hoTen,
      "gioi_tinh": $gioiTinh,
      "ngay_sinh": $ngaySinh,
      "sdt": $sdt,
      "bo_mon_id": $boMonId,
      "email_gv": $emailGV,
      "ten_vai_tro": $tenVaiTro,
      "ma_vai_tro": $maVaiTro,
      "ten_bo_mon": $tenBoMon,
    ''';
  }
}
