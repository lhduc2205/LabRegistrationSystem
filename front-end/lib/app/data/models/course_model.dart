class CourseModel {
  CourseModel({
    this.id,
    required this.maLopHocPhan,
    this.soLuongSinhVien,
    required this.thuId,
    required this.monHocId,
    required this.buoiHocId,
    this.giangVienId,
    this.hoTenGV,
    this.maGV,
    this.maMonHoc,
    // required this.lichThucHanhId,
    required this.hocKyNienKhoaId,
  });

  final int? id;
  final String maLopHocPhan;
  final int? soLuongSinhVien;
  final int thuId;
  final int monHocId;
  final int buoiHocId;
  final int? giangVienId;
  final String? hoTenGV;
  final String? maGV;
  final String? maMonHoc;

  // final dynamic lichThucHanhId;
  final int hocKyNienKhoaId;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        maLopHocPhan: json["ma_lop_hoc_phan"],
        soLuongSinhVien: json["so_luong_sinh_vien"],
        thuId: json["thu_id"],
        monHocId: json["mon_hoc_id"],
        buoiHocId: json["buoi_hoc_id"],
        giangVienId: json["giang_vien_id"],
        hoTenGV: json["ho_ten"],
        maGV: json["ma_gv"],
        // lichThucHanhId: json["lich_thuc_hanh_id"],
        hocKyNienKhoaId: json["hoc_ky_nien_khoa_id"],
        maMonHoc: json["ma_mon_hoc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ma_lop_hoc_phan": maLopHocPhan,
        "so_luong_sinh_vien": soLuongSinhVien,
        "thu_id": thuId,
        "mon_hoc_id": monHocId,
        "buoi_hoc_id": buoiHocId,
        "giang_vien_id": giangVienId,
        "ho_ten": hoTenGV,
        "ma_gv": maGV,
        // "lich_thuc_hanh_id": lichThucHanhId,
        "hoc_ky_nien_khoa_id": hocKyNienKhoaId,
        "ma_mon_hoc": maMonHoc,
      };
}
