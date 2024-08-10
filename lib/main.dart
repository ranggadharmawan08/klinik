import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthrecord/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:healthrecord/app/modules/lupapassword/controllers/lupapassword_controller.dart';
import 'package:healthrecord/app/modules/masuk/controllers/masuk_controller.dart';
import 'package:healthrecord/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:healthrecord/app/modules/antrianpasien/controllers/antrianpasien_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB6GSkznsGjWOXT9zPMiifBuW7wVfGHVoQ",
      appId: "1:657131157168:android:891e03e8fec5eb4aee6d75",
      messagingSenderId: "657131157168",
      projectId: "healthrecord-9a4a5",
      storageBucket: "healthrecord-9a4a5.appspot.com",
    ),
  );
  await GetStorage.init();
  Get.put(MasukController());
  Get.put(LupapasswordController());
  Get.put(OnboardingController());
  Get.put(AntrianpasienController());
  Get.put(DashboardController());
  runApp(
    ScreenUtilInit(
      designSize: const Size(450, 975),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          fontFamily: "Poppins",
        ),
      ),
    ),
  );
}
