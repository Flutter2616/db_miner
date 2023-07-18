import 'package:db_miner/view/add_quotes_screen.dart';
import 'package:db_miner/view/home_screen.dart';
import 'package:db_miner/view/quotes_screen.dart';
import 'package:db_miner/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: 'view',
        routes: {
          '/':(p0) => Splashscreen(),
          'home':(p0) => Homescreen(),
          'quotes':(p0) => Quotesscreen(),
          'view':(p0) => Viewscreen(),
        },
      ),
    ),
  );
}
