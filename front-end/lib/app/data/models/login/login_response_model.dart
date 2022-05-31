import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });

  final String message;
  final _Data data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        data: _Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class _Data {
  _Data({
    required this.id,
    // required this.email,
    // required this.fullName,
    required this.token,
  });

  final String id;
  // final String email;
  // final String fullName;
  final String token;

  factory _Data.fromJson(Map<String, dynamic> json) => _Data(
        id: json["id"],
        // email: json["email"],
        // fullName: json["fullName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.trim(),
        // "email": email.trim(),
        // "fullName": fullName,
        "token": token,
      };
}
