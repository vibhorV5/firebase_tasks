import 'package:firebase_tasks/Constant/TextStyles/text_styles.dart';
import 'package:firebase_tasks/Screens/LoginRegistration/Controller/login_controller.dart';
import 'package:firebase_tasks/Services/Firebase/Auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<LoginController>().registerEmail.value = '';
    Get.find<LoginController>().registerPassword.value = '';
    Get.find<LoginController>().phoneNumber.value = '';
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Registration/Log in Screen',
          style: kTextStyleTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          // color: Colors.black12,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),

              //Anonymous Sign in
              TextButton(
                onPressed: () async {
                  await AuthService().signInAnonymously();
                  debugPrint('Successfully logged in anonymously');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Text(
                    'Sign In Anonymously',
                    style: kTextStyleButtons.copyWith(
                        color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //OTP Signin
              Column(
                children: [
                  Text(
                    'Phone Verification !',
                    style: kTextStyleButtons.copyWith(
                        fontSize: 20, color: Colors.blueAccent),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      // Get.find<LoginController>().loginEmail = newValue!;
                      Get.find<LoginController>().phoneNumber.value = newValue!;
                    },
                    validator: (value) {
                      return Get.find<LoginController>()
                          .phoneNumberValidate(value!);
                    },
                    controller:
                        Get.find<LoginController>().phoneNumberController,
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
                      labelText: 'Phone',
                      labelStyle: kTextStyleButtons.copyWith(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   onSaved: (newValue) {
                  //     Get.find<LoginController>().loginPassword = newValue!;
                  //   },
                  //   validator: (value) {
                  //     return Get.find<LoginController>()
                  //         .passwordValidate(value!);
                  //   },
                  //   controller:
                  //       Get.find<LoginController>().loginPasswordController,
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 10.0),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.black,
                  //         // width: 2.0,
                  //       ),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.black,
                  //         // width: 2.0,
                  //       ),
                  //     ),
                  //     errorBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.red,
                  //         // width: 2.0,
                  //       ),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.grey,
                  //         // width: 2.0,
                  //       ),
                  //     ),
                  //     labelText: 'Password',
                  //     labelStyle: kTextStyleButtons.copyWith(
                  //       fontSize: 13,
                  //       color: Colors.black.withOpacity(0.3),
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.find<LoginController>().sendOtp();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: Text(
                        'Send OTP',
                        style: kTextStyleButtons.copyWith(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),

              //Registration
              // Form(
              //   key: Get.find<LoginController>().registrationFormKey,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   child: Column(
              //     children: [
              //       Text(
              //         'Register Now !',
              //         style: kTextStyleButtons.copyWith(
              //             fontSize: 20, color: Colors.blueAccent),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       // TextFormField(),
              //       // TextFormField(),
              //       TextFormField(
              //         onSaved: (newValue) {
              //           Get.find<LoginController>().registerEmail = newValue!;
              //         },
              //         validator: (value) {
              //           return Get.find<LoginController>()
              //               .emailValidate(value!);
              //         },
              //         controller: Get.find<LoginController>()
              //             .registrationEmailController,
              //         keyboardType: TextInputType.emailAddress,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.symmetric(
              //               vertical: 10.0, horizontal: 10.0),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           errorBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.red,
              //               // width: 2.0,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.grey,
              //               // width: 2.0,
              //             ),
              //           ),
              //           labelText: 'Email',
              //           labelStyle: kTextStyleButtons.copyWith(
              //             fontSize: 13,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       TextFormField(
              //         obscureText: true,
              //         onSaved: (newValue) {
              //           Get.find<LoginController>().registerPassword =
              //               newValue!;
              //         },
              //         validator: (value) {
              //           return Get.find<LoginController>()
              //               .passwordValidate(value!);
              //         },
              //         controller: Get.find<LoginController>()
              //             .registrationPasswordController,
              //         keyboardType: TextInputType.emailAddress,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.symmetric(
              //               vertical: 10.0, horizontal: 10.0),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           errorBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.red,
              //               // width: 2.0,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.grey,
              //               // width: 2.0,
              //             ),
              //           ),
              //           labelText: 'Password',
              //           labelStyle: kTextStyleButtons.copyWith(
              //             fontSize: 13,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              //         ),
              //       ),

              //       //Registration Button
              //       TextButton(
              //         onPressed: () async {
              //           FocusScope.of(context).unfocus();
              //           Get.find<LoginController>().checkRegistration();
              //           // Get.delete<LoginController>();
              //           // if (_formKey.currentState!.validate()) {
              //           //   dynamic result = await AuthService().registerUser(
              //           //     email: emailController,
              //           //     password: passwordController,
              //           //   );
              //           //   if (result == null) {
              //           //     setState(
              //           //       () {
              //           //         error = 'Enter a valid Email ID';
              //           //       },
              //           //     );
              //           //     ScaffoldMessenger.of(context)
              //           //         .showSnackBar(invalidEmailSnackBar);
              //           //   }

              //           //   debugPrint(emailController.text);
              //           //   debugPrint(passwordController.text);
              //           // }
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: Colors.black,
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 40, vertical: 8),
              //           child: Text(
              //             'Register',
              //             style: kTextStyleButtons.copyWith(
              //                 color: Colors.white, fontSize: 14),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),

              //Login
              // Form(
              //   key: Get.find<LoginController>().loginFormKey,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   child: Column(
              //     children: [
              //       Text(
              //         'Sign in !',
              //         style: kTextStyleButtons.copyWith(
              //             fontSize: 20, color: Colors.blueAccent),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       TextFormField(
              //         onSaved: (newValue) {
              //           Get.find<LoginController>().loginEmail = newValue!;
              //         },
              //         validator: (value) {
              //           return Get.find<LoginController>()
              //               .emailValidate(value!);
              //         },
              //         controller:
              //             Get.find<LoginController>().loginEmailController,
              //         keyboardType: TextInputType.emailAddress,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.symmetric(
              //               vertical: 10.0, horizontal: 10.0),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           errorBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.red,
              //               // width: 2.0,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.grey,
              //               // width: 2.0,
              //             ),
              //           ),
              //           labelText: 'Email',
              //           labelStyle: kTextStyleButtons.copyWith(
              //             fontSize: 13,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       TextFormField(
              //         onSaved: (newValue) {
              //           Get.find<LoginController>().loginPassword = newValue!;
              //         },
              //         validator: (value) {
              //           return Get.find<LoginController>()
              //               .passwordValidate(value!);
              //         },
              //         controller:
              //             Get.find<LoginController>().loginPasswordController,
              //         keyboardType: TextInputType.emailAddress,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.symmetric(
              //               vertical: 10.0, horizontal: 10.0),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.black,
              //               // width: 2.0,
              //             ),
              //           ),
              //           errorBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.red,
              //               // width: 2.0,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.grey,
              //               // width: 2.0,
              //             ),
              //           ),
              //           labelText: 'Password',
              //           labelStyle: kTextStyleButtons.copyWith(
              //             fontSize: 13,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           FocusScope.of(context).unfocus();
              //           Get.find<LoginController>().checkLogin();
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: Colors.black,
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 40, vertical: 8),
              //           child: Text(
              //             'Login',
              //             style: kTextStyleButtons.copyWith(
              //                 color: Colors.white, fontSize: 14),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
