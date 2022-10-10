import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tasks/Routes/routes.dart';
import 'package:firebase_tasks/Screens/AuthGate/View/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Firebase Sample Project',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const AuthGate(),
    );
  }
}
