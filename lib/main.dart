
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:petattix/constants/constants.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/dependancy_injaction.dart';
import 'package:petattix/views/screens/splash/splash_screen.dart';
import 'package:petattix/views/widgets/custom_text.dart';

import 'core/config/app_route.dart';
import 'core/config/light_themes.dart';
import 'core/device_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';





void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "${AppConstants.publishAbleKey}";
  Stripe.merchantIdentifier = "merchant.com.petattix.petattix";
  await Stripe.instance.applySettings();
  DependencyInjection dependencyInjection = DependencyInjection();
  dependencyInjection.dependencies();


  Get.put(ConnectivityService());

  DeviceUtils.lockDevicePortrait();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Pet Attix',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          theme: light(),
          themeMode: ThemeMode.light,
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}





class ConnectivityService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      print("🔌 Connectivity changed: $result");
      _updateConnectionStatus(result);
    });
  }

  Future<void> _initializeConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    isConnected.value = result != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
    update();
  }
}




class NoInterNetScreen extends StatelessWidget {
  final bool? isToast;
  final bool? isAppBar;
  final Widget child;

  const NoInterNetScreen(
      {super.key,
        required this.child,
        this.isToast = false,
        this.isAppBar = true});




  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();

    return Obx(() {
      final isConnected = connectivityService.isConnected.value;

      return Stack(
        children: [
          child,
          if (!isConnected)
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.w),
                    child: Image.asset("assets/images/noInternetImage.png"),
                  ),

                  CustomText(
                    text: "Oops!",
                    fontSize: 30.h,
                    color: Colors.red,
                    top: 10.h,
                    fontWeight: FontWeight.w800,
                    bottom: 10.h,
                  ),
                  CustomText(
                    text:
                    "There was some problem, Check your connection and try again",
                    maxline: 3,
                    left: 30.w,
                    right: 30.w,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

}





// nibor60831@mv6a.com
// jonajoh568@arqsis.com
// casicak893@fandoe.com local