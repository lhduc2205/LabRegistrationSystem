class LoginRequestModel {
  String email;
  String mat_khau;

  LoginRequestModel({required this.email, required this.mat_khau});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    email: json["email"],
    mat_khau: json["mat_khau"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "mat_khau": mat_khau,
  };
}