import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/helper/currency_get_helper.dart';
import 'package:petattix/views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../helper/prefs_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    getCurrency();
    super.initState();
  }


  getCurrency()async{
    await CurrencyHelper.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 107.h),

              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                  text: "Welcome to PetAttix!",
                  fontWeight: FontWeight.w600,
                  color: Color(0xff592B00),
                  fontSize: 22.h,
                  top: 26.h),

              CustomText(
                text: "Looking to sell your pet accessories and start earning?",
                color: Color(0xff592B00),
                maxline: 2,
                bottom: 28.h,
                top: 74.h,
              ),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              SizedBox(height: 26.h),

              CustomButton(
                  leftIcon: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Assets.icons.meneyIcon.svg(),
                  ),
                  title: "Sell Accessories",
                  onpress: () async{

                    PermissionStatus status = await Permission.location.request();

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return BottomNavBar();
                    }));


                    if (status.isGranted) {
                      // You got permission
                      print("Location permission granted");
                    } else if (status.isDenied) {
                      // Denied but not permanently
                      print("Location permission denied");
                    } else if (status.isPermanentlyDenied) {
                      // Guide user to app settings
                      await Permission.location.request();
                      // openAppSettings();
                    }
                  }),

              SizedBox(height: 20.h),

              CustomButton(
                  title: "Maybe later",
                  onpress: () {
                    // Get.toNamed(AppRoutes.bottomNavBar);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return BottomNavBar();
                    }));
                  },
                  color: Color(0xFFFFEBD9),
                  boderColor: Colors.transparent,
                  titlecolor: AppColors.primaryColor),

              SizedBox(height: 40.h)
            ],
          ),
        ),
      ),
    );
  }
}


//
// Future<void> showLocationPermissionDialog(BuildContext context) async {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       title: Text("Location Permission"),
//       content: Text("This app needs your location to function properly."),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("Cancel"),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             Navigator.pop(context);
//             PermissionStatus status = await Permission.location.request();
//
//             if (status.isGranted) {
//               // You got permission
//               print("Location permission granted");
//             } else if (status.isDenied) {
//               // Denied but not permanently
//               print("Location permission denied");
//             } else if (status.isPermanentlyDenied) {
//               // Guide user to app settings
//               openAppSettings();
//             }
//           },
//           child: Text("Allow"),
//         ),
//       ],
//     ),
//   );
// }
//
