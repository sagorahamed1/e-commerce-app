

import 'package:get/get.dart';

import '../../views/screens/auth/enable_location/enable_location_screen.dart';
import '../../views/screens/auth/forgot/forgot_screen.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/otp/opt_screen.dart';
import '../../views/screens/auth/reset/reset_password_screen.dart';
import '../../views/screens/auth/set_drop_off_location_screen/set_drop_off_location_screen.dart';
import '../../views/screens/auth/sing_up/sign_up_screen.dart';
import '../../views/screens/home/all_product_screen.dart';
import '../../views/screens/home/cart_screen.dart';
import '../../views/screens/home/product_details_screen.dart';
import '../../views/screens/message/chat_profile_screen.dart';
import '../../views/screens/message/media_screen.dart';
import '../../views/screens/message/message_screen.dart';
import '../../views/screens/notification/notification_screen.dart';
import '../../views/screens/onboarding/onboarding_screen.dart';
import '../../views/screens/post/edit_my_product_screent.dart';
import '../../views/screens/profile/edit_profile_screen.dart';
import '../../views/screens/profile/profile_information_screen.dart';
import '../../views/screens/profile/wallet_history_screen.dart';
import '../../views/screens/profile/wallet_screen.dart';
import '../../views/screens/profile/wish_list_screen.dart';
import '../../views/screens/profile/withdraw_success_screen.dart';
import '../../views/screens/purchas/confirm_purchase_screen.dart';
import '../../views/screens/purchas/confirmed.dart';
import '../../views/screens/purchas/courier_screen.dart';
import '../../views/screens/purchas/make_payment.dart';
import '../../views/screens/purchas/order_summary_screen.dart';
import '../../views/screens/purchas/select_drop_off_point.dart';
import '../../views/screens/purchas/shipment_screen.dart';
import '../../views/screens/refund/refund_request_screen.dart';
import '../../views/screens/setting/change_password_screen.dart';
import '../../views/screens/setting/privacy_policy_all_screen.dart';
import '../../views/screens/setting/setting_screen.dart';
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
  // static const String cartScreen = "/CartScreen";
  static const String confirmPurchaseScreen = "/ConfirmPurchaseScreen";
  static const String makePayment = "/MakePayment";
  static const String confirmed = "/Confirmed";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String profileInformationScreen = "/ProfileInformationScreen";
  static const String settingScreen = "/SettingScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String privacyPolicyAllScreen = "/PrivacyPolicyAllScreen";
  static const String walletScreen = "/WalletScreen";
  static const String walletHistoryScreen = "/WalletHistoryScreen";
  static const String chatProfileScreen = "/ChatProfileScreen";
  static const String mediaScreen = "/MediaScreen";
  static const String refundRequestScreen = "/RefundRequestScreen";
  static const String wishListScreen = "/WishListScreen";
  static const String editMyProductScreent = "/EditMyProductScreent";
  static const String shipmentScreen = "/ShipmentScreen";
  static const String courierScreen = "/CourierScreen";
  static const String setDropOffLocationScreen = "/SetDropOffLocationScreen";
  static const String dropOffPointScreen = "/DropOffPointScreen";
  static const String orderSummaryScreen = "/OrderSummaryScreen";
  static const String withdrawSuccessScreen = "/WithdrawSuccessScreen";



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
    // GetPage(name: cartScreen, page: () =>  CartScreen()),
    GetPage(name: confirmPurchaseScreen, page: () =>  ConfirmPurchaseScreen()),
    GetPage(name: makePayment, page: () =>  MakePayment()),
    GetPage(name: confirmed, page: () =>  Confirmed()),
    GetPage(name: editProfileScreen, page: () =>  EditProfileScreen()),
    GetPage(name: profileInformationScreen, page: () =>  ProfileInformationScreen()),
    GetPage(name: settingScreen, page: () =>  SettingScreen()),
    GetPage(name: changePasswordScreen, page: () =>  ChangePasswordScreen()),
    GetPage(name: privacyPolicyAllScreen, page: () =>  PrivacyPolicyAllScreen()),
    GetPage(name: walletScreen, page: () =>  WalletScreen()),
    GetPage(name: walletHistoryScreen, page: () =>  WalletHistoryScreen()),
    GetPage(name: chatProfileScreen, page: () =>  ChatProfileScreen()),
    GetPage(name: mediaScreen, page: () =>  MediaScreen()),
    GetPage(name: refundRequestScreen, page: () =>  RefundRequestScreen()),
    GetPage(name: wishListScreen, page: () =>  WishListScreen()),
    GetPage(name: editMyProductScreent, page: () =>  EditMyProductScreent()),
    GetPage(name: shipmentScreen, page: () =>  ShipmentScreen()),
    GetPage(name: courierScreen, page: () =>  CourierScreen()),
    GetPage(name: setDropOffLocationScreen, page: () =>  SetDropOffLocationScreen()),
    GetPage(name: dropOffPointScreen, page: () =>  DropOffPointScreen()),
    GetPage(name: orderSummaryScreen, page: () =>  OrderSummaryScreen()),
    GetPage(name: withdrawSuccessScreen, page: () =>  WithdrawSuccessScreen()),
  ];
}
