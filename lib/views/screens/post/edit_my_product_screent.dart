import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';

import '../../../controller/product_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../helper/toast_message_helper.dart';
import '../../widgets/cusotom_check_box.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_popup_menu.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class EditMyProductScreent extends StatefulWidget {
  const EditMyProductScreent({super.key});

  @override
  State<EditMyProductScreent> createState() => _EditMyProductScreentState();
}

class _EditMyProductScreentState extends State<EditMyProductScreent> {

  ProductController productController = Get.put(ProductController());
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController conditionCtrl = TextEditingController();
  TextEditingController usageDurationCtrl = TextEditingController();
  TextEditingController expireDateCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController purchasePriceCtrl = TextEditingController();
  TextEditingController sellingPriceCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController selectedCategoryCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();

  bool _isChecked = false;
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();


  @override
  void initState() {
    var index = Get.arguments["index"];
   var product = productController.myProduct[index];

   titleCtrl.text = product.productName.toString();
   conditionCtrl.text = product.condition.toString();
   descriptionCtrl.text = product.description.toString();
   purchasePriceCtrl.text = product.purchasingPrice.toString();
   sellingPriceCtrl.text = product.sellingPrice.toString();
   categoryCtrl.text = product.category.toString();
   quantityCtrl.text = product.quantity.toString();
   brandCtrl.text = product.brand.toString();
   // locationCtrl.text = product..toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Product"),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: forKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  height: 230.h,
                  width: double.infinity,
                  // padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/uploadImage.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _images.isEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImages,
                        child: Assets.icons.uploadPlusIcon
                            .svg(width: 44.w, height: 44.h),
                      ),
                      SizedBox(height: 10.h),
                      const Text("Upload up to 5 images"),
                    ],
                  )
                      : Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            _images[_currentIndex],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Left Arrow
                        Positioned(
                          left: 8.w,
                          child: GestureDetector(
                            onTap: _prevImage,
                            child: CircleAvatar(
                              radius: 14.r,
                              backgroundColor: Colors.black38,
                              child:
                              Icon(Icons.arrow_left, color: Colors.white),
                            ),
                          ),
                        ),

                        // Right Arrow
                        Positioned(
                          right: 8.w,
                          child: GestureDetector(
                            onTap: _nextImage,
                            child: CircleAvatar(
                              radius: 14.r,
                              backgroundColor: Colors.black38,
                              child:
                              Icon(Icons.arrow_right, color: Colors.white),
                            ),
                          ),
                        ),

                        // Remove Icon
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: GestureDetector(
                            onTap: () => _removeImage(_currentIndex),
                            child: CircleAvatar(
                              radius: 14.r,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(Icons.close,
                                  size: 14.r, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                CustomTextField(
                    controller: titleCtrl,
                    labelText: "Product Title",
                    hintText: "Product Title"),
                CustomTextField(
                    controller: locationCtrl,
                    labelText: "Address",
                    hintText: "Address"),
                CustomTextField(
                    controller: brandCtrl,
                    labelText: "Brand Name",
                    hintText: "Brand Name"),
                CustomTextField(
                    controller: quantityCtrl,
                    keyboardType: TextInputType.number,
                    labelText: "Quantity",
                    hintText: "Quantity"),
                Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        text: "Selected Category", color: Colors.black, bottom: 6.h)),
                CustomTextField(
                  readOnly: true,
                  hintText: "Select category",
                  controller: categoryCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select category';
                    }
                    return null;
                  },
                  suffixIcon: CustomPopupMenu(
                      items: productController.category,
                      onSelected: (p0) {
                        selectedCategoryCtrl.text = p0;
                        final selectCarThis = productController.category
                            .firstWhere((x) => x.id.toString() == p0);
                        categoryCtrl.text = selectCarThis.name.toString();
                        setState(() {});
                      }),
                ),
                CustomTextField(
                    controller: conditionCtrl,
                    labelText: "Condition",
                    hintText: "Condition"),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: purchasePriceCtrl,
                          labelText: "Purchase Price",
                          hintText: "Purchase Price"),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: sellingPriceCtrl,
                          labelText: "Selling Price",
                          hintText: "Selling Price"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    CircularCheckBox(
                      size: 20.r,
                      isChecked: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value;
                        });
                      },
                    ),
                    CustomText(
                        text: "Negotiable",
                        fontSize: 16.h,
                        color: Colors.black,
                        left: 10.w,
                        right: 5.w),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                    controller: descriptionCtrl,
                    labelText: "Description",
                    hintText: "Description"),
                CustomButton(
                    title: "Edit Product",
                    onpress: () {
                      if(forKey.currentState!.validate()){
                        if(_images.length != 0){
                          productController.addProduct(
                            isBoosted: false,
                            context: context,
                              productName: titleCtrl.text,
                              phurcasingPrice: purchasePriceCtrl.text,
                              sellingPrice: sellingPriceCtrl.text,
                              // quantity: quantityCtrl.text,
                              condition: conditionCtrl.text,
                              description: descriptionCtrl.text,
                              category: categoryCtrl.text,
                              negotiable: _isChecked,
                              brand: brandCtrl.text,
                              images: _images);
                        }else{
                          ToastMessageHelper.showToastMessage(context, "Please select your product images");
                        }
                      }

                    }),
                SizedBox(height: 120.h)
              ],
            ),
          ),
        ),
      ),
    );
  }



  final ImagePicker _picker = ImagePicker();

  List<File> _images = [];

  int _currentIndex = 0;

  Future<void> _pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null) {
      final newImages = picked.map((x) => File(x.path)).toList();
      setState(() {
        final remaining = 5 - _images.length;
        _images.addAll(newImages.take(remaining));
        _currentIndex = _images.length - 1;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_images.isNotEmpty) {
        _currentIndex = index > 0 ? index - 1 : 0;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void _nextImage() {
    if (_currentIndex < _images.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }
}
