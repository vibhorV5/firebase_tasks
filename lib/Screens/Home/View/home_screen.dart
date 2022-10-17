import 'package:firebase_tasks/Constant/TextStyles/text_styles.dart';
import 'package:firebase_tasks/Screens/AddPage/add_page.dart';
import 'package:firebase_tasks/Screens/ListPage/list_page.dart';
import 'package:firebase_tasks/Services/Firebase/Auth/firebase_auth.dart';
import 'package:firebase_tasks/Services/Firebase/Database/database_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        actions: [
          TextButton(
            onPressed: () async {
              // Navigator.of(context).pop();
              await AuthService().signOut(context);

              //crash
              // FirebaseCrashlytics.instance.crash();
              debugPrint('Successfully logged out');
              // Get.toNamed(home);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          // color: Colors.black12,
          child: Column(
            children: [
              Container(
                height: mediaQuery.height,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await DatabaseServices().setPersonalDetails();
                        Get.snackbar(
                          'Success',
                          'Personal Details Set',
                          backgroundColor: Colors.green.withOpacity(0.5),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text('Save Personal Information'),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.to(const AddPage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text('Add Employee Info'),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.to(const ListPage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text('List Employees Page'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
