class SubjectModel {
  SubjectModel({
    this.id,
    required this.maMonHoc,
    required this.tenMonHoc,
    required this.soTinChi,
    required this.vietTat,
    this.phanMemID,
  });

  final int? id;
  final String maMonHoc;
  final String tenMonHoc;
  final int soTinChi;
  final String vietTat;
  final List? phanMemID;

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json["id"],
    maMonHoc: json["ma_mon_hoc"],
    tenMonHoc: json["ten_mon_hoc"],
    soTinChi: json["so_tin_chi"],
    vietTat: json["viet_tat"],
    phanMemID: json["phan_mem_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ma_mon_hoc": maMonHoc,
    "ten_mon_hoc": tenMonHoc,
    "so_tin_chi": soTinChi,
    "vietTat": vietTat,
    "phan_mem_id": phanMemID,
  };

  String toString() {
    return '''
    "id": $id,
    "ma_mon_hoc": $maMonHoc,
    "ten_mon_hoc": $tenMonHoc,
    "so_tin_chi": $soTinChi,
    "viet_tat": $vietTat,
    "phan_mem_id": $phanMemID,
    ''';
  }
}
