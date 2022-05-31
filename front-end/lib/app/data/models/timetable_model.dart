class TimetableModel {
  TimetableModel({
    required this.id,
    required this.maNhom,
    required this.soLuongSinhVien,
    required this.trangThai,
    required this.lopHocPhanId,
    required this.ngayBatDau,
    required this.tuanId,
    required this.thuId,
    required this.nhomThId,
    required this.phongId,
    required this.buoiHocId,
    required this.maLopHocPhan,
    required this.monHocId,
    required this.giangVienId,
    required this.hocKyNienKhoaId,
    this.maMonHoc,
  });

  final int id;
  final int maNhom;
  final int soLuongSinhVien;
  final bool trangThai;
  final int lopHocPhanId;
  final DateTime ngayBatDau;
  int tuanId;
  int thuId;
  final int nhomThId;
  int phongId;
  int buoiHocId;
  final String maLopHocPhan;
  final int monHocId;
  final int giangVienId;
  final int hocKyNienKhoaId;
  final String? maMonHoc;

  factory TimetableModel.fromJson(Map<String, dynamic> json) => TimetableModel(
        id: json["id"],
        maNhom: json["ma_nhom"],
        soLuongSinhVien: json["so_luong_sinh_vien"],
        trangThai: json["trang_thai"],
        lopHocPhanId: json["lop_hoc_phan_id"],
        ngayBatDau: DateTime.parse(json["ngay_bat_dau"]),
        tuanId: json["tuan_id"],
        thuId: json["thu_id"],
        nhomThId: json["nhom_th_id"],
        phongId: json["phong_id"],
        buoiHocId: json["buoi_hoc_id"],
        maLopHocPhan: json["ma_lop_hoc_phan"],
        monHocId: json["mon_hoc_id"],
        giangVienId: json["giang_vien_id"],
        hocKyNienKhoaId: json["hoc_ky_nien_khoa_id"],
        maMonHoc: json["ma_mon_hoc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ma_nhom": maNhom,
        "so_luong_sinh_vien": soLuongSinhVien,
        "trang_thai": trangThai,
        "lop_hoc_phan_id": lopHocPhanId,
        "ngay_bat_dau": ngayBatDau.toIso8601String(),
        "tuan_id": tuanId,
        "thu_id": thuId,
        "nhom_th_id": nhomThId,
        "phong_id": phongId,
        "buoi_hoc_id": buoiHocId,
        "ma_lop_hoc_phan": maLopHocPhan,
        "mon_hoc_id": monHocId,
        "giang_vien_id": giangVienId,
        "hoc_ky_nien_khoa_id": hocKyNienKhoaId,
        "ma_mon_hoc": maMonHoc,
      };
}
