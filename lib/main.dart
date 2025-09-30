
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:petattix/constants/constants.dart';
import 'package:petattix/helper/dependancy_injaction.dart';
import 'package:petattix/views/screens/splash/splash_screen.dart';

import 'core/config/app_route.dart';
import 'core/config/light_themes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "${AppConstants.publishAbleKey}";
  await Stripe.instance.applySettings();
  DependencyInjection dependencyInjection = DependencyInjection();
  dependencyInjection.dependencies();
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
      child: const SplashScreen(),
    );
  }
}





// nibor60831@mv6a.com