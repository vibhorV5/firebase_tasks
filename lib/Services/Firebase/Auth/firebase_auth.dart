import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tasks/Screens/AuthGate/View/auth_gate.dart';
import 'package:firebase_tasks/Screens/Home/View/home_screen.dart';
import 'package:firebase_tasks/Screens/LoginRegistration/Controller/login_controller.dart';
import 'package:firebase_tasks/Screens/Otp/View/otp_screen.dart';
import 'package:firebase_tasks/Services/Firebase/Analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final AnalyticsService _analyticsService = AnalyticsService();

  //Send OTP/Verify OTP
  Future sendFirebaseOtp({
    required String mobile,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$mobile',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        var result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          // showLoading(context);
          Get.back();
          Get.to(() => const HomeScreen());
          print('its verify');
        } else {
          print("User not present");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        Get.back();
        print('=====exception=========');
        print(exception);
        Get.snackbar('Exception', 'Please try again',
            snackPosition: SnackPosition.BOTTOM);
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.find<LoginController>().verification.value = verificationId;
        // Get.toNamed(otpScreen);
        Get.to(() => const OtpScreen());
        Get.snackbar('Otp Sent', 'Otp has been sent to $mobile',
            snackPosition: SnackPosition.BOTTOM);
        print('verification id');
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.find<LoginController>().verification.value = verificationId;
        print('code AutoRetreivalTimeout');
        print(verificationId);
        print("Timout");
      },
    );
  }

  //Firebase verify OTP
  Future<void> verifyFirebaseOtp(String mobile, String smsCode) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: Get.find<LoginController>().verification.value,
        smsCode: smsCode);
    try {
      var result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        // otpVerification(mobile,smsCode);
        Get.to(() => const HomeScreen());
      } else {
        Get.back();
        Get.snackbar('Connection Failed',
            'Some Error occurred in connecting to server, please try again later',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Incorrect Otp', 'enter correct otp',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Firebase Resend OTP
  Future<void> reSendFirebaseOtp(context, String mobile) async {
    _auth.verifyPhoneNumber(
        phoneNumber: '+91$mobile',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          var result = await _auth.signInWithCredential(credential);
          User? user = result.user;
          if (user != null) {
            // showLoading(context);
            // otpVerification(mobile,'123456');
            print('its verify');
          } else {
            print("User not present");
          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          print('=====exception=========');
          print(exception);
          // customSnackBar('Please try again', exception.toString());
        },
        codeSent: (verificationId, [forceResendingToken]) {
          Get.find<LoginController>().verification.value = verificationId;
          print('verification id');
          print(verificationId);
          print('force ResendingToken');
          print(forceResendingToken);
          //customSnackBar(Constants.otpSent,'OTP sent to $mobile');
        },
        codeAutoRetrievalTimeout: (String verificationId) async {
          Get.find<LoginController>().verification.value = verificationId;
          print('code AutoRetreivalTimeout');
          print(verificationId);
          print("Timout");
        });
  }

  //Sign in Anonymously
  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      await _analyticsService.setUserId(user!.uid);
      debugPrint('User Id = ${user.uid}');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerUser({
    required TextEditingController email,
    required TextEditingController password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //Sign In using email and password
  Future signIn({
    required TextEditingController email,
    required TextEditingController password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    } catch (e) {
      debugPrint(e.toString());
      return (null);
    }
  }

  //Logout
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AuthGate()),
          (route) => false);
      // Get.to(const LogInScreen());
      debugPrint(currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }
}
