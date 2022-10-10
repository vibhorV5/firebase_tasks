import 'package:firebase_tasks/Screens/AuthGate/View/auth_gate.dart';
import 'package:firebase_tasks/Screens/Home/View/home_screen.dart';
import 'package:firebase_tasks/Screens/LoginRegistration/View/login_screen.dart';
import 'package:firebase_tasks/Screens/Otp/View/otp_screen.dart';
import 'package:get/get.dart';

const String authgate = '/authgate';
const String home = '/homeScreen';
const String loginScreen = '/loginScreen';
const String otpScreen = '/loginScreen';

class Routes {
  static final routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LogInScreen()),
    GetPage(name: authgate, page: () => const AuthGate()),
    GetPage(name: otpScreen, page: () => const OtpScreen()),
  ];
}
