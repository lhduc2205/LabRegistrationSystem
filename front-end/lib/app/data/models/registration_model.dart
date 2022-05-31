class RegistrationModel {
  RegistrationModel({
    required this.id,
    required this.maNhom,
    required this.soLuongSinhVien,
    required this.lopHocPhanId,
    required this.nhomThId,
    this.tenMonHoc,
    this.maMonHoc,
    this.vietTat,
    this.maLopHocPhan,
    this.hoTenGV,
    this.gioiTinhGV,
    required this.daXep,
    required this.chuaXep,
  });

  final int id;
  final int maNhom;
  final int soLuongSinhVien;
  final int lopHocPhanId;
  final int nhomThId;
  final String? tenMonHoc;
  final String? maMonHoc;
  final String? vietTat;
  final String? maLopHocPhan;
  final String? hoTenGV;
  final bool? gioiTinhGV;
  final List<int> daXep;
  final List<int> chuaXep;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        id: json["id"],
        maNhom: json["ma_nhom"],
        soLuongSinhVien: json["so_luong_sinh_vien"],
        lopHocPhanId: json["lop_hoc_phan_id"],
        nhomThId: json["nhom_th_id"],
        tenMonHoc: json["ten_mon_hoc"],
        maMonHoc: json["ma_mon_hoc"],
        vietTat: json["viet_tat"],
        maLopHocPhan: json["ma_lop_hoc_phan"],
        hoTenGV: json["ho_ten"],
        gioiTinhGV: json["gioi_tinh"],
        daXep: List<int>.from(json["da_xep"].map((x) => x)),
        chuaXep: List<int>.from(json["chua_xep"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ma_nhom": maNhom,
        "so_luong_sinh_vien": soLuongSinhVien,
        "lop_hoc_phan_id": lopHocPhanId,
        "nhom_th_id": nhomThId,
        "ten_mon_hoc": tenMonHoc,
        "ma_mon_hoc": maMonHoc,
        "viet_tat": vietTat,
        "ma_lop_hoc_phan": maLopHocPhan,
        "ho_ten": hoTenGV,
        "gioi_tinh": gioiTinhGV,
        "da_xep": List<dynamic>.from(daXep.map((x) => x)),
        "chua_xep": List<dynamic>.from(chuaXep.map((x) => x)),
      };
}
