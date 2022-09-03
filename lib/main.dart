import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pinterest/services/hive_service.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.dbName);
  runApp(const MyApp());
 // HiveService.clear();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const OverlaySupport.global(
      child: MaterialApp(

        home: MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
