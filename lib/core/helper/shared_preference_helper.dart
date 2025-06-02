import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences? preferences;

  static const String accessTokenKey = 'access_token';
  static const String accessTokenType = 'access_type';
  static const String resetPassTokenKey = 'reset_pass_token';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String userPhoneNumberKey = 'user_phone_number';
  static const String mobileCode = 'mobile_code';
  static const String rememberMeKey = 'remember me';
  static const String generalSettingKey = 'general-setting-key';
  static const String moduleSettingKey = 'module-setting-key';
  static const String fcmDeviceKey = 'device-key';
  static const String needTwoFactorVerification = 'need-tfa';

  static const String userIdKey = 'user_id';
  static const String hasNewNotificationKey = 'new-notification-key';

  static const String theme = 'theme';
  static const String token = 'token';

  static const String firstTimeAppOpeningStatus = 'first_time_app_open';
  static const String socialId = 'social_id';
  static const String userSelectedCountryCode =
      'user-selected-country_code'; // this is used for currently located user country tracking

  static const String countryCode =
      'country_code'; // this country code are used in localization purpose
  static const String languageCode = 'language_code';
  static const String languageKey = 'language-key';
  static const String languageListKey = 'language-list-key';
  static Future<bool> saveBool(
      {required String key, required bool value}) async {
    return await preferences?.setBool(key, value) ?? false;
  }

  // Get a boolean value from SharedPreferences
  static bool? getBool({required String key}) {
    return preferences?.getBool(key);
  }

  // Save a string (language code) in SharedPreferences
  static Future<bool> saveString(
      {required String key, required String value}) async {
    return await preferences?.setString(key, value) ?? false;
  }

  // Get a string (language code) from SharedPreferences
  static String? getString({required String key}) {
    return preferences?.getString(key);
  }

  // Save the current selected language
  static Future<void> saveLanguage(String languageCode) async {
    await saveString(key: 'language', value: languageCode);
  }

  // Get the saved language code, defaulting to 'en' if not set
  static String getSavedLanguage() {
    return getString(key: 'language') ??
        'en'; // Default to 'en' if no language is saved
  }
}
