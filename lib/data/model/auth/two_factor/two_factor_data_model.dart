

import 'dart:convert';

import '../../booking_history/cancel_booking_response_model.dart';

TwoFactorCodeModel twoFactorCodeModelFromJson(String str) => TwoFactorCodeModel.fromJson(json.decode(str));

class TwoFactorCodeModel {
  String? the0;
  String? remark;
  String? status;
  Message? message;
  Data? data;

  TwoFactorCodeModel({
    this.the0,
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory TwoFactorCodeModel.fromJson(Map<String, dynamic> json) => TwoFactorCodeModel(
        the0: json["0"],
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? qrCodeUrl;
  String? secret;

  Data({
    this.qrCodeUrl,
    this.secret,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrCodeUrl: json["qr_code_url"],
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "qr_code_url": qrCodeUrl,
        "secret": secret,
      };
}
