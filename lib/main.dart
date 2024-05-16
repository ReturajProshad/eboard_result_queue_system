import 'package:eboard_result_queue/firebase_options.dart';
import 'package:eboard_result_queue/ui/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double _deviceHeight;
  late double _devicWeight;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicWeight = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      title: "EBoardRDemo",
      home: homePage(
        deviceHeight: _deviceHeight,
        devicWeight: _devicWeight,
      ),
    );
  }
}
