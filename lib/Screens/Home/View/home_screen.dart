import 'package:firebase_tasks/Constant/TextStyles/text_styles.dart';
import 'package:firebase_tasks/Services/Firebase/Auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          // color: Colors.black12,
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  // Navigator.of(context).pop();
                  await AuthService().signOut(context);
                  debugPrint('Successfully logged out');
                  // Get.toNamed(home);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.deepOrange,
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: kTextStyleButtons,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
