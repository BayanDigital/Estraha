import '../auth/sign_up_model/registration_response_model.dart';

// To parse this JSON data, do
//
//     final generalSettingsResponseModel = generalSettingsResponseModelFromJson(jsonString);

import 'dart:convert';

GeneralSettingResponseModel generalSettingsResponseModelFromJson(String str) => GeneralSettingResponseModel.fromJson(json.decode(str));

String generalSettingsResponseModelToJson(GeneralSettingResponseModel data) => json.encode(data.toJson());

class GeneralSettingResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GeneralSettingResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) => GeneralSettingResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "status": status,
    "message": message?.toJson(),
    "data": data?.toJson(),
  };
}

class Data {
  GeneralSetting? generalSetting;
  String? socialLoginRedirect;

  Data({
    this.generalSetting,
    this.socialLoginRedirect,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    generalSetting: json["general_setting"] == null ? null : GeneralSetting.fromJson(json["general_setting"]),
    socialLoginRedirect: json["social_login_redirect"],
  );

  Map<String, dynamic> toJson() => {
    "general_setting": generalSetting?.toJson(),
    "social_login_redirect": socialLoginRedirect,
  };
}

class GeneralSetting {
  int? id;
  String? siteName;
  String? curText;
  String? curSym;
  String? emailFrom;
  String? emailFromName;
  String? smsTemplate;
  String? smsFrom;
  String? pushTitle;
  String? pushTemplate;
  String? baseColor;
  String? secondaryColor;
  FirebaseConfig? firebaseConfig;
  GlobalShortcodes? globalShortcodes;
  int? kv;
  int? ev;
  int? en;
  int? sv;
  int? sn;
  int? pn;
  int? forceSsl;
  int? inAppPayment;
  int? maintenanceMode;
  int? securePassword;
  int? agree;
  int? multiLanguage;
  int? registration;
  String? activeTemplate;
  SocialiteCredentials? socialiteCredentials;
  String? lastCron;
  String? availableVersion;
  int? systemCustomized;
  int? paginateNumber;
  int? currencyFormat;
  int? isEnableOwnerRequest;
  String? billPerMonth;
  int? paymentBefore;
  int? maxStarRating;
  int? popularityCountFrom;
  List<String>? remindBeforeDays;
  int? maximumPaymentMonth;
  String? appVideo;
  dynamic createdAt;
  String? updatedAt;

  GeneralSetting({
    this.id,
    this.siteName,
    this.curText,
    this.curSym,
    this.emailFrom,
    this.emailFromName,
    this.smsTemplate,
    this.smsFrom,
    this.pushTitle,
    this.pushTemplate,
    this.baseColor,
    this.secondaryColor,
    this.firebaseConfig,
    this.globalShortcodes,
    this.kv,
    this.ev,
    this.en,
    this.sv,
    this.sn,
    this.pn,
    this.forceSsl,
    this.inAppPayment,
    this.maintenanceMode,
    this.securePassword,
    this.agree,
    this.multiLanguage,
    this.registration,
    this.activeTemplate,
    this.socialiteCredentials,
    this.lastCron,
    this.availableVersion,
    this.systemCustomized,
    this.paginateNumber,
    this.currencyFormat,
    this.isEnableOwnerRequest,
    this.billPerMonth,
    this.paymentBefore,
    this.maxStarRating,
    this.popularityCountFrom,
    this.remindBeforeDays,
    this.maximumPaymentMonth,
    this.appVideo,
    this.createdAt,
    this.updatedAt,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
    id: json["id"],
    siteName: json["site_name"],
    curText: json["cur_text"],
    curSym: json["cur_sym"],
    emailFrom: json["email_from"],
    emailFromName: json["email_from_name"],
    smsTemplate: json["sms_template"],
    smsFrom: json["sms_from"],
    pushTitle: json["push_title"],
    pushTemplate: json["push_template"],
    baseColor: json["base_color"],
    secondaryColor: json["secondary_color"],
    firebaseConfig: json["firebase_config"] == null ? null : FirebaseConfig.fromJson(json["firebase_config"]),
    globalShortcodes: json["global_shortcodes"] == null ? null : GlobalShortcodes.fromJson(json["global_shortcodes"]),
    kv: json["kv"],
    ev: json["ev"],
    en: json["en"],
    sv: json["sv"],
    sn: json["sn"],
    pn: json["pn"],
    forceSsl: json["force_ssl"],
    inAppPayment: json["in_app_payment"],
    maintenanceMode: json["maintenance_mode"],
    securePassword: json["secure_password"],
    agree: json["agree"],
    multiLanguage: json["multi_language"],
    registration: json["registration"],
    activeTemplate: json["active_template"],
    socialiteCredentials: json["socialite_credentials"] == null ? null : SocialiteCredentials.fromJson(json["socialite_credentials"]),
    lastCron: json["last_cron"],
    availableVersion: json["available_version"],
    systemCustomized: json["system_customized"],
    paginateNumber: json["paginate_number"],
    currencyFormat: json["currency_format"],
    isEnableOwnerRequest: json["is_enable_owner_request"],
    billPerMonth: json["bill_per_month"],
    paymentBefore: json["payment_before"],
    maxStarRating: json["max_star_rating"],
    popularityCountFrom: json["popularity_count_from"],
    remindBeforeDays: json["remind_before_days"] == null ? [] : List<String>.from(json["remind_before_days"]!.map((x) => x)),
    maximumPaymentMonth: json["maximum_payment_month"],
    appVideo: json["app_video"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_name": siteName,
    "cur_text": curText,
    "cur_sym": curSym,
    "email_from": emailFrom,
    "email_from_name": emailFromName,
    "sms_template": smsTemplate,
    "sms_from": smsFrom,
    "push_title": pushTitle,
    "push_template": pushTemplate,
    "base_color": baseColor,
    "secondary_color": secondaryColor,
    "firebase_config": firebaseConfig?.toJson(),
    "global_shortcodes": globalShortcodes?.toJson(),
    "kv": kv,
    "ev": ev,
    "en": en,
    "sv": sv,
    "sn": sn,
    "pn": pn,
    "force_ssl": forceSsl,
    "in_app_payment": inAppPayment,
    "maintenance_mode": maintenanceMode,
    "secure_password": securePassword,
    "agree": agree,
    "multi_language": multiLanguage,
    "registration": registration,
    "active_template": activeTemplate,
    "socialite_credentials": socialiteCredentials?.toJson(),
    "last_cron": lastCron,
    "available_version": availableVersion,
    "system_customized": systemCustomized,
    "paginate_number": paginateNumber,
    "currency_format": currencyFormat,
    "is_enable_owner_request": isEnableOwnerRequest,
    "bill_per_month": billPerMonth,
    "payment_before": paymentBefore,
    "max_star_rating": maxStarRating,
    "popularity_count_from": popularityCountFrom,
    "remind_before_days": remindBeforeDays == null ? [] : List<dynamic>.from(remindBeforeDays!.map((x) => x)),
    "maximum_payment_month": maximumPaymentMonth,
    "app_video": appVideo,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class FirebaseConfig {
  String? apiKey;
  String? authDomain;
  String? projectId;
  String? storageBucket;
  String? messagingSenderId;
  String? appId;
  String? measurementId;

  FirebaseConfig({
    this.apiKey,
    this.authDomain,
    this.projectId,
    this.storageBucket,
    this.messagingSenderId,
    this.appId,
    this.measurementId,
  });

  factory FirebaseConfig.fromJson(Map<String, dynamic> json) => FirebaseConfig(
    apiKey: json["apiKey"],
    authDomain: json["authDomain"],
    projectId: json["projectId"],
    storageBucket: json["storageBucket"],
    messagingSenderId: json["messagingSenderId"],
    appId: json["appId"],
    measurementId: json["measurementId"],
  );

  Map<String, dynamic> toJson() => {
    "apiKey": apiKey,
    "authDomain": authDomain,
    "projectId": projectId,
    "storageBucket": storageBucket,
    "messagingSenderId": messagingSenderId,
    "appId": appId,
    "measurementId": measurementId,
  };
}

class GlobalShortcodes {
  String? siteName;
  String? siteCurrency;
  String? currencySymbol;

  GlobalShortcodes({
    this.siteName,
    this.siteCurrency,
    this.currencySymbol,
  });

  factory GlobalShortcodes.fromJson(Map<String, dynamic> json) => GlobalShortcodes(
    siteName: json["site_name"],
    siteCurrency: json["site_currency"],
    currencySymbol: json["currency_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName,
    "site_currency": siteCurrency,
    "currency_symbol": currencySymbol,
  };
}

class SocialiteCredentials {
  Facebook? google;
  Facebook? facebook;
  Facebook? linkedin;

  SocialiteCredentials({
    this.google,
    this.facebook,
    this.linkedin,
  });

  factory SocialiteCredentials.fromJson(Map<String, dynamic> json) => SocialiteCredentials(
    google: json["google"] == null ? null : Facebook.fromJson(json["google"]),
    facebook: json["facebook"] == null ? null : Facebook.fromJson(json["facebook"]),
    linkedin: json["linkedin"] == null ? null : Facebook.fromJson(json["linkedin"]),
  );

  Map<String, dynamic> toJson() => {
    "google": google?.toJson(),
    "facebook": facebook?.toJson(),
    "linkedin": linkedin?.toJson(),
  };
}

class Facebook {
  String? clientId;
  String? clientSecret;
  String? status;

  Facebook({
    this.clientId,
    this.clientSecret,
    this.status,
  });

  factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
    clientId: json["client_id"],
    clientSecret: json["client_secret"],
    status: json["status"] != null ? json["status"].toString() : "",
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "client_secret": clientSecret,
    "status": status,
  };
}


class SocialiteCredentialsValue {
  String? clientId;
  String? clientSecret;
  String? status;

  SocialiteCredentialsValue({
    this.clientId,
    this.clientSecret,
    this.status,
  });

  factory SocialiteCredentialsValue.fromJson(Map<String, dynamic> json) => SocialiteCredentialsValue(
    clientId: json["client_id"].toString(),
    clientSecret: json["client_secret"].toString(),
    status: json["status"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "client_secret": clientSecret,
    "status": status,
  };
}
