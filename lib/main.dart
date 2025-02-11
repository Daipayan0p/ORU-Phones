import 'package:flutter/material.dart';
import 'package:oru_phones/src/app/app.locator.dart';
import 'package:oru_phones/src/view/splash_screen.dart';
import 'package:stacked_services/stacked_services.dart';


void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
