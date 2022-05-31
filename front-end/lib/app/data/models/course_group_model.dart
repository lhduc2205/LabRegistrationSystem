class CourseGroup {
  CourseGroup({
    required this.id,
    required this.maNhom,
    required this.soLuongSinhVien,
    required this.trangThai,
    required this.lopHocPhanId,
    this.maMonHoc,
    this.tenMonHoc,
    this.maLopHocPhan,
  });

  final int id;
  final int maNhom;
  final int soLuongSinhVien;
  final bool trangThai;
  final int lopHocPhanId;
  final String? maMonHoc;
  final String? tenMonHoc;
  final String? maLopHocPhan;

  factory CourseGroup.fromJson(Map<String, dynamic> json) => CourseGroup(
        id: json["id"],
        maNhom: json["ma_nhom"],
        soLuongSinhVien: json["so_luong_sinh_vien"],
        trangThai: json["trang_thai"],
        lopHocPhanId: json["lop_hoc_phan_id"],
        maMonHoc: json["ma_mon_hoc"],
        tenMonHoc: json["ten_mon_hoc"],
        maLopHocPhan: json["ma_lop_hoc_phan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ma_nhom": maNhom,
        "so_luong_sinh_vien": soLuongSinhVien,
        "trang_thai": trangThai,
        "lop_hoc_phan_id": lopHocPhanId,
        "ma_mon_hoc": maMonHoc,
        "ten_mon_hoc": tenMonHoc,
        "ma_lop_hoc_phan": maLopHocPhan,
      };
}
