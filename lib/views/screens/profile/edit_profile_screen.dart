import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

import '../../../controller/profile_controller.dart';
import '../../../services/api_constants.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  Uint8List? _image;
  File? selectedIMage;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    firstNameCtrl.text = profileController.firstName.toString();
    lastNameCtrl.text = profileController.lastName.toString();
    phoneCtrl.text = profileController.phone.toString();
    addressCtrl.text = profileController.address.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Information"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {
                  showImagePickerOption(context);
                },
                child: SizedBox(
                  height: 86.h,
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                        height: 85.h,
                         width: 85.w,
                         clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.memory(_image!, fit: BoxFit.cover))
                          : CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstants.imageBaseUrl}/${profileController.image}",
                              height: 85.h,
                              width: 85.w,
                              boxShape: BoxShape.circle,
                            ),
                      Positioned(
                          bottom: 7.h,
                          left: 30.w,
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: firstNameCtrl,
                hintText: "first name",
                labelText: "Your First Name",
                contentPaddingVertical: 10.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
              ),
              CustomTextField(
                controller: lastNameCtrl,
                hintText: "last name",
                labelText: "Your Last Name",
                contentPaddingVertical: 10.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
              ),
              CustomTextField(
                controller: phoneCtrl,
                hintText: "phone no",
                labelText: "Phone No.",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
              CustomTextField(
                controller: addressCtrl,
                hintText: "address",
                labelText: "Address",
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                contentPaddingVertical: 10.h,
              ),
              
              

              
              SizedBox(height: 50.h),



              Obx(() =>
                 CustomButton(
                     loading: profileController.updateProfileLoading.value,
                     title: "Update Profile", onpress: () {

                  profileController.profileUpdate(
                      firstName: firstNameCtrl.text,
                      lastName: lastNameCtrl.text,
                      address: addressCtrl.text,
                      image: selectedIMage,
                      phone: phoneCtrl.text, context: context
                  );

                }),
              ),





              SizedBox(height: 100.h)
            ],
          ),
        ),
      ),
    );
  }

  //==================================> ShowImagePickerOption Function <===============================
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                            ),
                            CustomText(text: 'Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                            ),
                            CustomText(text: 'Camera')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Get.back();
  }
}
