import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

import '../../../controller/profile_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../../services/api_constants.dart';
import '../../widgets/cachanetwork_image.dart';

class ProfileInformationScreen extends StatefulWidget {
  ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());



  @override
  void initState() {
   firstNameCtrl.text =  profileController.firstName.toString();
   lastNameCtrl.text =  profileController.lastName.toString();
   emailCtrl.text =  profileController.email.toString();
   phoneCtrl.text =  profileController.phone.toString();
   addressCtrl.text =  profileController.address.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Information"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 26.h),
          
              CustomNetworkImage(
                imageUrl: "${ApiConstants.imageBaseUrl}/${profileController.image}",
                height: 85.h,
                width: 85.w,
                boxShape: BoxShape.circle,
              ),
          
          
              SizedBox(height: 16.h),
          
          
          
              CustomTextField(
                readOnly: true,
                controller: firstNameCtrl,
                hintText: "first name",
                labelText: "Your First Name",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
          
          
          
              CustomTextField(
                readOnly: true,
                controller: lastNameCtrl,
                hintText: "last name",
                labelText: "Your Last Name",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
          
          
              CustomTextField(
                readOnly: true,
                controller: emailCtrl,
                hintText: "email",
                labelText: "E-mail",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
          
          
          
              CustomTextField(
                readOnly: true,
                controller: phoneCtrl,
                hintText: "phone",
                labelText: "Phone No.",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
          
          
          
              CustomTextField(
                readOnly: true,
                controller: addressCtrl,
                hintText: "address",
                labelText: "Address",
                hintextColor: Colors.black,
                borderColor: Color(0xff592B00),
                contentPaddingVertical: 10.h,
              ),




              CustomButton(
                  color: AppColors.primaryColor,
                  title: "Change Drop-off Location", onpress: (){

                Get.toNamed(AppRoutes.setDropOffLocationScreen, arguments: {
                  "screenType" : "edit"
                });

              }),




              SizedBox(height: 50.h),
          
          
              CustomButton(title: "Edit Profile", onpress: (){
                Get.toNamed(AppRoutes.editProfileScreen);
              }),
          
              SizedBox(height: 100.h)
          
          
            ],
          ),
        ),
      ),
    );
  }
}
