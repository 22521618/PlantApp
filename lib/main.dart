import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        //keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
        apiKey: "AIzaSyDMYFqv9xCI9LwDgY8BP5qkxzDtm0Eq-AE",
        appId: "1:197034131219:android:0224dde61f269fc8a564e6",
        messagingSenderId: "197034131219",
        projectId: "plantapp-9af90"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Gilroy',
      ),
      home: const SplashPage(),
    );
  }
}
