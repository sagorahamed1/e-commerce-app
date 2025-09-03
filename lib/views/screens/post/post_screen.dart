import 'dart:io';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/controller/product_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';

import '../../widgets/cusotom_check_box.dart';
import '../../widgets/custom_popup_menu.dart';
import '../../widgets/custom_text.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.fetchCategory();
    productController.getMyProduct();
    productController.fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          iconTheme: IconThemeData(color: Color(0xff592B00)),
          backgroundColor: AppColors.bgColor,
          centerTitle: true,
          title: CustomText(
            text: "Post",
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff592B00),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 45.h,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            ),
            tabs: const [
              Text('        Create Post         '),
              Text('         My Post        '),
              Text('         Purchases       '),
            ],
            views: [_createPost(), _myPostList(), _mySalesList(_selected)],
            onChange: (int index) {
              if (index == 1) {
                productController.getMyProduct();
              } else {}
            },
          ),
        ));
  }

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController conditionCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController purchasePriceCtrl = TextEditingController();
  TextEditingController sellingPriceCtrl = TextEditingController();
  // TextEditingController quantityCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController selectedCategoryCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();
  // TextEditingController heightCtrl = TextEditingController();
  // TextEditingController widthCtrl = TextEditingController();
  // TextEditingController lengthCtrl = TextEditingController();
  // TextEditingController weightCtrl = TextEditingController();
  // TextEditingController postalCodeCtrl = TextEditingController();
  // TextEditingController countryCodeCtrl = TextEditingController();
  // TextEditingController countryIdCtrl = TextEditingController();
  // TextEditingController countryTitleCtrl = TextEditingController();
  // TextEditingController addressLine1Ctrl = TextEditingController();
  // TextEditingController addressLine2Ctrl = TextEditingController();
  // TextEditingController cityCtrl = TextEditingController();
  TextEditingController sizeCtrl = TextEditingController();

  bool _isChecked = false;
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  Widget _createPost() {
    return SingleChildScrollView(
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
                                child: Icon(Icons.arrow_right,
                                    color: Colors.white),
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
              keyboardType: TextInputType.number,
                controller: sizeCtrl,
                labelText: "Size",
                hintText: "Size"),


            // CustomTextField(
            //     controller: cityCtrl,
            //     labelText: "City",
            //     hintText: "City"),
            //
            //
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //     controller: heightCtrl,
            //     labelText: "Purcell Height CM",
            //     hintText: "Purcell Height CM"),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //     controller: widthCtrl,
            //     labelText: "Purcell Width CM",
            //     hintText: "Purcell Width CM"),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //     controller: lengthCtrl,
            //     labelText: "Purcell Length CM",
            //     hintText: "Purcell Length CM"),
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //     controller: weightCtrl,
            //     labelText: "Purcell Weight KG",
            //     hintText: "Purcell Weight KG"),
            //
            //
            //
            //
            // CustomTextField(
            //   controller: countryTitleCtrl,
            //   labelText: "Country",
            //   hintText: "Country",
            //   onTap: () {
            //     productController.isListVisible.value = true;
            //   },
            //   onChanged: (value) {
            //     productController.searchCountry(value);
            //   },
            // ),
            //
            // Obx(() {
            //   if (!productController.isListVisible.value) {
            //     return const SizedBox.shrink();
            //   }
            //
            //   if (productController.isLoading.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }
            //
            //   return Container(
            //     height: 150,
            //     decoration: BoxDecoration(
            //       color: Colors.black12,
            //       border: Border.all(color: Colors.grey, width: 0.05)
            //     ),
            //     child: ListView.builder(
            //       itemCount: productController.filteredCountry.length,
            //       itemBuilder: (context, index) {
            //         final country = productController.filteredCountry[index];
            //         return GestureDetector(
            //           onTap: () {
            //             countryTitleCtrl.text = country.title;
            //             countryCodeCtrl.text = country.countryCode;
            //             countryIdCtrl.text = country.countryId.toString();
            //             productController.isListVisible.value = false; // close list
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(country.title),
            //           ),
            //         );
            //       },
            //     ),
            //   );
            // }),
            //
            //
            // CustomTextField(
            //     controller: addressLine1Ctrl,
            //     labelText: "Address line 1",
            //     hintText: "Address line 1"),
            //
            //
            //
            // CustomTextField(
            //     controller: addressLine2Ctrl,
            //     labelText: "Address line 2",
            //     hintText: "Address line 2"),
            //
            //
            // CustomTextField(
            //   keyboardType: TextInputType.number,
            //     controller: postalCodeCtrl,
            //     labelText: "Postal Code",
            //     hintText: "Postal Code"),

            CustomTextField(
                controller: brandCtrl,
                labelText: "Brand Name",
                hintText: "Brand Name"),
            // CustomTextField(
            //     controller: quantityCtrl,
            //     keyboardType: TextInputType.number,
            //     labelText: "Quantity",
            //     hintText: "Quantity"),
            Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                    text: "Selected Category",
                    color: Colors.black,
                    bottom: 6.h)),
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
              loading: productController.productAddLoading.value,
                title: "Create a Post",
                onpress: () {
                  if (forKey.currentState!.validate()) {
                    if (_images.length != 0) {
                      productController.addProduct(
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
                          size: sizeCtrl.text,
                          // city: cityCtrl.text,
                          // height: heightCtrl.text,
                          // width: widthCtrl.text,
                          // countryCode: countryCodeCtrl.text,
                          // length: lengthCtrl.text,
                          // countryId: countryIdCtrl.text,
                          // postalCode: postalCodeCtrl.text,
                          // weight: widthCtrl.text,
                          // addressLine1: addressLine1Ctrl.text,
                          // addressLine2: addressLine2Ctrl.text,
                          // country: countryTitleCtrl.text,
                          images: _images);
                    } else {
                      ToastMessageHelper.showToastMessage(
                          context, "Please select your product images");
                    }
                  }
                }),
            SizedBox(height: 120.h)
          ],
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

  Widget _myPostList() {
    return Obx(
      () => productController.myProductLoading.value
          ? ShimmerListView()
          : productController.myProduct.isEmpty
              ? NoDataFoundCard()
              : ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
                  itemCount: productController.myProduct.length,
                  itemBuilder: (context, index) {
                    var product = productController.myProduct[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: const Color(0xfffef4ea), // Card background
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 0), // shadow in all directions
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Section

                            CustomNetworkImage(
                                borderRadius: BorderRadius.circular(8.r),
                                imageUrl:
                                    "${ApiConstants.imageBaseUrl}/${product.images?[0].image}",
                                height: 139.h,
                                width: 109.w),

                            SizedBox(width: 7.w),

                            // Info Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                          text: "${product.productName}",
                                          fontWeight: FontWeight.w600,
                                          bottom: 4.h,
                                          color: Colors.black),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(
                                              0xffD1F5D3), // Card background
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0,
                                                  0), // shadow in all directions
                                            ),
                                          ],
                                        ),
                                        child: CustomText(
                                          text: "${product.status}",
                                          left: 8.w,
                                          right: 8.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Assets.icons.moneyIconCard.svg(),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        text: "${product.purchasingPrice}\$",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                      text: "Pet Type: Cat",
                                      fontSize: 12.h,
                                      bottom: 4.h,
                                      color: Colors.black),
                                  CustomText(
                                    text: "Condition: ${product.condition}",
                                    fontSize: 12.h,
                                    bottom: 4.h,
                                    color: Colors.black,
                                  ),
                                  CustomText(
                                    text: "Location: ${product.category}",
                                    fontSize: 12.h,
                                    color: Colors.black,
                                    bottom: 7.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CustomButton(
                                            height: 26.h,
                                            title: "Edit",
                                            onpress: () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .editMyProductScreent,
                                                  arguments: {"index": index});
                                            },
                                            color: Colors.transparent,
                                            fontSize: 11.h,
                                            loaderIgnore: true,
                                            boderColor: AppColors.primaryColor,
                                            titlecolor: AppColors.primaryColor),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(
                                          () => CustomButton(
                                              loading: productController
                                                  .deleteMyProductLoading.value,
                                              loaderIgnore: true,
                                              height: 26.h,
                                              title: "Delete",
                                              onpress: () {
                                                productController
                                                    .deleteMyProduct(
                                                        context: context,
                                                        id: product.id
                                                            .toString());
                                              },
                                              fontSize: 11.h),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  final List<String> _options = ['In Progress', 'Packed', 'Handover'];
  String _selected = 'In Progress';

  Widget _mySalesList(String? selectedItem) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: const Color(0xfffef4ea), // Card background
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 0), // shadow in all directions
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section

                CustomNetworkImage(
                    borderRadius: BorderRadius.circular(8.r),
                    imageUrl:
                        "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                    height: 139.h,
                    width: 109.w),

                SizedBox(width: 7.w),

                // Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                              text: "Cat Travel Bag (Used)",
                              fontWeight: FontWeight.w600,
                              bottom: 4.h,
                              color: Colors.black),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffD1F5D3), // Card background
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset:
                                      Offset(0, 0), // shadow in all directions
                                ),
                              ],
                            ),
                            child: CustomText(
                              text: "Live",
                              left: 8.w,
                              right: 8.w,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Assets.icons.moneyIconCard.svg(),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "30\$",
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      CustomText(
                          text: "Pet Type: Cat",
                          fontSize: 12.h,
                          bottom: 4.h,
                          color: Colors.black),
                      CustomText(
                        text: "Condition: Used – 60% Usable",
                        fontSize: 12.h,
                        bottom: 4.h,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: "Location: Banani, Dhaka",
                        fontSize: 12.h,
                        color: Colors.black,
                        bottom: 7.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 35.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF4EA),
                            // light background
                            border: Border.all(color: const Color(0xFFFF7A01)),
                            // orange border
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedItem,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Color(0xFFFF7A01)),
                              dropdownColor: const Color(0xFFFEF4EA),
                              borderRadius: BorderRadius.circular(16),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selected = newValue;
                                  });
                                }
                              },
                              items: _options.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
