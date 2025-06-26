import 'dart:convert';

import 'package:aqua_inspector/features/auth/data/models/user_info.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String token;
  String tokenType;
  int expiresIn;
  UserInfo userInfo;

  LoginModel({required this.token, required this.tokenType, required this.expiresIn, required this.userInfo});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(token: json["token"], tokenType: json["tokenType"], expiresIn: json["expiresIn"], userInfo: UserInfo.fromJson(json["userInfo"]));

  Map<String, dynamic> toJson() => {"token": token, "tokenType": tokenType, "expiresIn": expiresIn, "userInfo": userInfo.toJson()};
}
