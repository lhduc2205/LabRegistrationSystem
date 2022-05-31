class SemesterModel {
  SemesterModel({
     required this.id,
     required this.ngayBatDau,
     required this.ngayKetThuc,
     required this.tuanId,
     required this.hocKyNienKhoaId,
     required this.maTuan,
     required this.tenTuan,
     required this.soTuan,
     required this.hocKyId,
     required this.nienKhoaId,
     required this.maHocKy,
     required this.tenHocKy,
     required this.nienKhoa,
  });

  final int id;
  final DateTime ngayBatDau;
  final dynamic ngayKetThuc;
  final int tuanId;
  final int hocKyNienKhoaId;
  final int maTuan;
  final String tenTuan;
  final int soTuan;
  final int hocKyId;
  final int nienKhoaId;
  final String maHocKy;
  final String tenHocKy;
  final String nienKhoa;

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
    id: json["id"],
    ngayBatDau: DateTime.parse(json["ngay_bat_dau"]),
    ngayKetThuc: json["ngay_ket_thuc"],
    tuanId: json["tuan_id"],
    hocKyNienKhoaId: json["hoc_ky_nien_khoa_id"],
    maTuan: json["ma_tuan"],
    tenTuan: json["ten_tuan"],
    soTuan: json["so_tuan"],
    hocKyId: json["hoc_ky_id"],
    nienKhoaId: json["nien_khoa_id"],
    maHocKy: json["ma_hoc_ky"],
    tenHocKy: json["ten_hoc_ky"],
    nienKhoa: json["nien_khoa"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ngay_bat_dau": ngayBatDau.toIso8601String(),
    "ngay_ket_thuc": ngayKetThuc,
    "tuan_id": tuanId,
    "hoc_ky_nien_khoa_id": hocKyNienKhoaId,
    "ma_tuan": maTuan,
    "ten_tuan": tenTuan,
    "so_tuan": soTuan,
    "hoc_ky_id": hocKyId,
    "nien_khoa_id": nienKhoaId,
    "ma_hoc_ky": maHocKy,
    "ten_hoc_ky": tenHocKy,
    "nien_khoa": nienKhoa,
  };
}
