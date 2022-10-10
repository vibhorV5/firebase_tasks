import 'package:firebase_tasks/Constant/TextStyles/text_styles.dart';
import 'package:firebase_tasks/Screens/LoginRegistration/Controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<LoginController>().otpCode.value = '';
    Get.find<LoginController>().phoneNumber.value = '';
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Text(
                    'OTP Verification !',
                    style: kTextStyleButtons.copyWith(
                        fontSize: 20, color: Colors.blueAccent),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      // Get.find<LoginController>().loginEmail = newValue!;
                      // Get.find<LoginController>().phoneNumber.value =
                      //     newValue!;
                    },
                    // validator: (value) {
                    //   return Get.find<LoginController>()
                    //       .phoneNumberValidate(value!);
                    // },
                    controller: Get.find<LoginController>().otpController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          // width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          // width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          // width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          // width: 2.0,
                        ),
                      ),
                      labelText: 'Otp',
                      labelStyle: kTextStyleButtons.copyWith(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.find<LoginController>().verifyOtp();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: Text(
                        'Verify OTP',
                        style: kTextStyleButtons.copyWith(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
