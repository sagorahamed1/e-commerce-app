

import 'package:get/get.dart';

import '../../views/screens/auth/enable_location/enable_location_screen.dart';
import '../../views/screens/auth/forgot/forgot_screen.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/otp/opt_screen.dart';
import '../../views/screens/auth/reset/reset_password_screen.dart';
import '../../views/screens/auth/sing_up/sign_up_screen.dart';
import '../../views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../views/screens/home/all_product_screen.dart';
import '../../views/screens/home/cart_screen.dart';
import '../../views/screens/home/product_details_screen.dart';
import '../../views/screens/message/message_screen.dart';
import '../../views/screens/notification/notification_screen.dart';
import '../../views/screens/onboarding/onboarding_screen.dart';
import '../../views/screens/splash/splash_screen.dart';
import '../../views/screens/wellcome/welcome_screen.dart';


class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String logInScreen = "/LogInScreen";
  static const String forgotScreen = "/ForgotScreen";
  static const String optScreen = "/OptScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String enableLocationScreen = "/EnableLocationScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String messageScreen = "/MessageScreen";
  static const String welcomeScreen = "/WelcomeScreen";
  static const String allProductScreen = "/AllProductScreen";
  static const String productDetailsScreen = "/ProductDetailsScreen";
  static const String cartScreen = "/CartScreen";



  static List<GetPage> get routes => [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () =>  OnboardingScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: logInScreen, page: () =>  LogInScreen()),
    GetPage(name: forgotScreen, page: () =>  ForgotScreen()),
    GetPage(name: optScreen, page: () =>  OptScreen()),
    GetPage(name: resetPasswordScreen, page: () =>  ResetPasswordScreen()),
    GetPage(name: enableLocationScreen, page: () =>  EnableLocationScreen()),
    GetPage(name: notificationScreen, page: () =>  NotificationScreen()),
    GetPage(name: messageScreen, page: () =>  MessageScreen()),
    GetPage(name: welcomeScreen, page: () =>  WelcomeScreen()),
    GetPage(name: allProductScreen, page: () =>  AllProductScreen()),
    GetPage(name: productDetailsScreen, page: () =>  ProductDetailsScreen()),
    GetPage(name: cartScreen, page: () =>  CartScreen()),
  ];
}
