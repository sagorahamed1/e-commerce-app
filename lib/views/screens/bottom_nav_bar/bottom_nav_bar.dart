import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/chat_list_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../main.dart';
import '../home/home_screen.dart';
import '../message/message_user_screen.dart';
import '../post/post_screen.dart';
import '../profile/profile_screen.dart'; // Add your custom colors



class BottomNavBar extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BottomNavBar> {


  ProductController productController = Get.put(ProductController());
  ProfileController profileController = Get.put(ProfileController());
  ChatListController chatListController = Get.put(ChatListController());
  final connectivityService = Get.find<ConnectivityService>();

  final List<Widget> screens = [
     HomeScreen(),
     PostScreen(),
     MessageUserScreen(),
     ProfileScreen(),
  ];

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBody: true,
      body: Obx(() {
        final isConnected = connectivityService.isConnected.value;
        
       return NoInterNetScreen(child: screens[currentIndex]);
      } ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: sizeH * .07,
          margin: EdgeInsets.all(sizeH * .015),
          padding: EdgeInsets.all(sizeH * .01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(sizeH * .05),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor,
                offset: Offset(0, 0),
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0),
              _buildNavItem(1),
              _buildNavItem(2),
              _buildNavItem(3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final sizeH = MediaQuery.sizeOf(context).height;
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });


        if(index == 0){
          productController.allProduct.clear();
          productController.getAllProduct();
        }else if(index == 1){

        }else if(index == 2){

          chatListController.chatUsers.value = [];
          chatListController.getChatUser();

        }else if(index == 3){
          profileController.getLocalData();
          print("===============profile Image : ${profileController.image.value}");
        }
        print("====================================================== index : $index");
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: sizeH * .06,
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              shape: BoxShape.circle),
          child:  Padding(padding: EdgeInsets.all(6.r),
            child: index == 0
                ? isSelected ? Assets.icons.home.svg() : Assets.icons.homeUnselected.svg()
                : index == 1
                ? Assets.icons.plus
                .svg(color: isSelected ? AppColors.primaryColor : Colors.grey)
                : index == 2
                ? Assets.icons.message.svg(color: isSelected ? AppColors.primaryColor : Colors.grey)
                : isSelected ? Assets.icons.profileSelected.svg()  :  Assets.icons.profile.svg(),
          )
      ),
    );
  }
}