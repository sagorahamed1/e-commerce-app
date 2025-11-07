import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
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
  TextEditingController conditionCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController sellingPriceCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController selectedCategoryCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();
  TextEditingController sizeCtrl = TextEditingController();
  TextEditingController productIdCtrl = TextEditingController();



  TextEditingController weightCtrl = TextEditingController();
  TextEditingController widthCtrl = TextEditingController();
  TextEditingController lengthCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController postalCodeCtrl = TextEditingController();
  TextEditingController houseNumberCtrl = TextEditingController();
  TextEditingController countryTitleCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();



  FocusNode companyFocus = FocusNode();
  FocusNode address1Focus = FocusNode();
  FocusNode address2Focus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode postalFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode houseNumberFocus = FocusNode();
  FocusNode countryIdFocus = FocusNode();
  FocusNode countryTitleFocus = FocusNode();
  FocusNode weightFocus = FocusNode();
  FocusNode widthFocus = FocusNode();
  FocusNode lengthFocus = FocusNode();
  FocusNode heightFocus = FocusNode();
  FocusNode stateFocus = FocusNode();


  bool _isChecked = false;
  bool pickMyLocation = true;
  bool _isBoost = false;
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();
  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");


  @override
  void initState() {
    var index = Get.arguments["index"];
    var product = productController.myProduct[index];

    titleCtrl.text = product.productName.toString();
    conditionCtrl.text = product.condition.toString();
    descriptionCtrl.text = product.description.toString();
    sellingPriceCtrl.text = product.sellingPrice.toString();
    categoryCtrl.text = product.category.toString();
    brandCtrl.text = product.brand.toString();
    selectedCategoryCtrl.text = product.category.toString();
    sizeCtrl.text = product.size.toString();
    productIdCtrl.text = product.id.toString();

        addressLine1Ctrl.text = product.collectionAddress?.address ?? '';
        houseNumberCtrl.text = product.collectionAddress?.houseNumber ?? '';
        cityCtrl.text = product.collectionAddress?.city ?? '';
        stateCtrl.text = product.collectionAddress?.city ?? '';
        postalCodeCtrl.text = product.collectionAddress?.postalCode ?? '';
        countryTitleCtrl.text = product.collectionAddress?.country ?? '';


        heightCtrl.text = product.height ?? "";
        weightCtrl.text = product.weight ?? "";
        lengthCtrl.text = product.length ?? "";
        widthCtrl.text = product.width ?? "";




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Product"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: forKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),


                Container(
                  height: 230.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/uploadImage.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _images.isEmpty
                      ? Center( // majhe rakhbo
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // content ke chhoto kore maje rakhbe
                      children: [
                        GestureDetector(
                          onTap: _pickImages,
                          child: Assets.icons.uploadPlusIcon
                              .svg(width: 44.w, height: 44.h),
                        ),
                        SizedBox(height: 10.h),
                        const Text("Upload up to 5 images"),
                      ],
                    ),
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
                              child: Icon(
                                  Icons.arrow_left, color: Colors.white),
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
                              child: Icon(
                                  Icons.arrow_right, color: Colors.white),
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
                              child: Icon(
                                  Icons.close, size: 14.r, color: Colors.white),
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


                CustomTextField(
                    controller: brandCtrl,
                    labelText: "Brand Name",
                    hintText: "Brand Name"),


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


                CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: sellingPriceCtrl,
                    labelText: "Selling Price",
                    hintText: "Selling Price"),


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
                    maxLine: 4,
                    controller: descriptionCtrl,
                    labelText: "Description",
                    hintText: "Description"),









                /// Extra Shipment Fields
                CustomTextField(
                  focusNode: weightFocus,
                  controller: weightCtrl,
                  labelText: "Weight (kg)",
                  hintText: "Enter weight",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Weight is required";
                    }
                    final num? weight = num.tryParse(value);
                    if (weight == null) return "Please enter a valid number";
                    if (weight < 1) return "Weight must be at least 1 KG";
                    if (weight > 100) return "Weight must be at most 100 KG";
                    return null;
                  },
                ),
                CustomTextField(
                  focusNode: widthFocus,
                  controller: widthCtrl,
                  labelText: "Width (cm)",
                  hintText: "Enter width",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Width is required";
                    }
                    final num? width = num.tryParse(value);
                    if (width == null) return "Please enter a valid number";
                    if (width < 10) return "Width must be at least 10 CM";
                    if (width > 100) return "Width must be at most 100 CM";
                    return null;
                  },
                ),
                CustomTextField(
                  focusNode: lengthFocus,
                  controller: lengthCtrl,
                  labelText: "Length (cm)",
                  hintText: "Enter length",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Length is required";
                    }
                    final num? length = num.tryParse(value);
                    if (length == null) return "Please enter a valid number";
                    if (length < 1) return "Length must be at least 1 CM";
                    if (length > 100) return "Length must be at most 100 CM";
                    return null;
                  },
                ),
                CustomTextField(
                  focusNode: heightFocus,
                  controller: heightCtrl,
                  labelText: "Height (cm)",
                  hintText: "Enter height",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Height is required";
                    }
                    final num? height = num.tryParse(value);
                    if (height == null) return "Please enter a valid number";
                    if (height < 1) return "Height must be at least 1 CM";
                    if (height > 100) return "Height must be at most 100 CM";
                    return null;
                  },
                ),

                SizedBox(height: 20.h),



                Row(
                  children: [
                    CircularCheckBox(
                      size: 20.r,
                      isChecked: _isBoost,
                      onChanged: (value) {
                        setState(() {
                          _isBoost = value;
                        });
                      },
                    ),
                    CustomText(
                        text: "Boost This Add",
                        fontSize: 16.h,
                        color: Colors.black,
                        left: 10.w,
                        right: 5.w),
                  ],
                ),



                CustomText(
                    left: 30.w,
                    text: "Boost your ad to appear at the top of your audience’s feed for 3 days with just 1€.",
                    fontSize: 10.h,
                    maxline: 3,
                    textAlign: TextAlign.start),


                SizedBox(height: 28.h),


                Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: "Delivery Method", fontSize: 16.h, fontWeight: FontWeight.w600, color: Colors.black)),


                SizedBox(height: 10.h),
                Row(
                  children: [
                    CircularCheckBox(
                      size: 20.r,
                      isChecked: pickMyLocation,
                      onChanged: (value) {
                        setState(() {
                          pickMyLocation = value;
                        });
                      },
                    ),
                    CustomText(
                        text: "Pick up from my location",
                        fontSize: 16.h,
                        color: Colors.black,
                        left: 10.w,
                        right: 5.w),
                  ],
                ),



                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10.h),


                    CustomText(text: "Address",
                        fontWeight: FontWeight.w500,
                        bottom: 10.h),

                    GooglePlaceAutoCompleteTextField(
                      focusNode: address1Focus,
                      textEditingController: addressLine1Ctrl,
                      googleAPIKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0",
                      inputDecoration: InputDecoration(
                        hintText: "Select address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      boxDecoration: BoxDecoration(
                        color: const Color(0xFFFFF2E6),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (prediction) async {
                        final detail = await places.getDetailsByPlaceId(prediction.placeId!);
                        final comp = detail.result.addressComponents;

                        for (var c in comp) {
                          if (c.types.contains("locality")) {
                            cityCtrl.text = c.longName;
                          }
                          if (c.types.contains("postal_code")) {
                            postalCodeCtrl.text = c.longName;
                          }
                          if (c.types.contains("country")) {
                            countryTitleCtrl.text = c.longName;
                            houseNumberCtrl.text = c.shortName;

                          }
                        }
                      },
                      itemClick: (prediction) {
                        addressLine1Ctrl.text = prediction.description ?? "";
                        addressLine1Ctrl.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length),
                        );
                      },
                    ),

                    SizedBox(height: 10.h),


                    CustomTextField(
                      focusNode: countryTitleFocus,
                      controller: countryTitleCtrl,
                      labelText: "Country",
                      hintText: "Country",
                    ),


                    CustomTextField(
                      focusNode: postalFocus,
                      controller: postalCodeCtrl,
                      labelText: "Postal Code",
                      hintText: "Postal Code",
                    ),




                    Row(
                      children: [


                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            focusNode: stateFocus,
                            controller: stateCtrl,
                            labelText: "State",
                            hintText: "State",
                          ),
                        ),


                        SizedBox(width: 12.w),


                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            focusNode: cityFocus,
                            controller: cityCtrl,
                            labelText: "City",
                            hintText: "City",
                          ),
                        ),


                      ],
                    ),


                    CustomTextField(
                      focusNode: houseNumberFocus,
                      controller: houseNumberCtrl,
                      labelText: "House Number",
                      hintText: "House Number",
                    ),


                  ],
                ),



                SizedBox(height: 16.h),









                Obx(()=>
                   CustomButton(
                     loading: productController.productEditLoading.value,
                      title: "Edit Product",
                      onpress: () {
                        if (forKey.currentState!.validate()) {
                          if (_images.length != 0) {
                            productController.editProduct(
                                productId: productIdCtrl.text,
                                context: context,
                                productName: titleCtrl.text,
                                sellingPrice: sellingPriceCtrl.text,
                                condition: conditionCtrl.text,
                                description: descriptionCtrl.text,
                                category: categoryCtrl.text,
                                negotiable: _isChecked,
                                brand: brandCtrl.text,
                                size: sizeCtrl.text,
                                images: _images,
                                isBoosted: false,
                                width: widthCtrl.text,
                                height: heightCtrl.text,
                                length: lengthCtrl.text,
                                weight: weightCtrl.text,
                                address: addressLine1Ctrl.text,
                                address2: "",
                                city: cityCtrl.text,
                                companyName: houseNumberCtrl.text,
                                country: countryTitleCtrl.text,
                                houseNumber: houseNumberCtrl.text,
                                postalCode: postalCodeCtrl.text,
                                carrer_type: "collection_address"


                            );
                          } else {
                            ToastMessageHelper.showToastMessage(
                                context, "Please select your product images", title: "Warning");
                          }
                        }
                      }),
                ),
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
