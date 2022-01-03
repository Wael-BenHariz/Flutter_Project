// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gestion_de_stock/app/ui/pages/login_page/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/ui/pages/home_page/homepage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    locale: Get.deviceLocale,
    title: "GESTION DE STOCK",
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/login', page: () => const LoginPage())
    ],
  ));
}
