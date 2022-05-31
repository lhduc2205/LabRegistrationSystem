
class TimetableRegistrationModel {
  TimetableRegistrationModel({
    required this.id,
    required this.trangThai,
    required this.soLuongSv,
    required this.maNhom,
    required this.tuanId,
    required this.lopHocPhanId,
  });

  final int id;
  final bool trangThai;
  final int soLuongSv;
  final int maNhom;
  final List<int> tuanId;
  final int lopHocPhanId;

  factory TimetableRegistrationModel.fromJson(Map<String, dynamic> json) => TimetableRegistrationModel(
    id: json["id"],
    trangThai: json["trang_thai"],
    soLuongSv: json["so_luong_sinh_vien"],
    maNhom: json["ma_nhom"],
    tuanId: List<int>.from(json["tuan_id"].map((x) => x)),
    lopHocPhanId: json["lop_hoc_phan_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trang_thai": trangThai,
    "so_luong_sinh_vien": soLuongSv,
    "ma_nhom": maNhom,
    "tuan_id": List<dynamic>.from(tuanId.map((x) => x)),
    "lop_hoc_phan_id": lopHocPhanId,
  };
}
