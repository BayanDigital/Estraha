// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:booking_box/core/helper/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/messages.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'data/services/push_notification_service.dart';
import 'firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();
  SharedPreferenceHelper.preferences = sharedPrefs;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService(apiClient: Get.find()).setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(languages: languages),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) => GetMaterialApp(
            title: MyStrings.appName.tr,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.noTransition,
            transitionDuration: const Duration(milliseconds: 200),
            initialRoute: RouteHelper.splashScreen,
            navigatorKey: Get.key,
            theme: themeProvider.themeData,
            getPages: RouteHelper().routes,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(
              localizeController.locale.languageCode,
              localizeController.locale.countryCode,
            ),
          ),
        );
      },
    );
  }
}
