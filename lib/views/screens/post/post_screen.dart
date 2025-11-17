import 'dart:convert';
import 'dart:io';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/controller/product_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/currency_get_helper.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';
import 'package:http/http.dart' as http;

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
    productController.getMySales();


    productController.fetchDropOffAddress().then((_) {
      final data = productController.dropOffData.value;
      if (data != null) {
        addressLine1Ctrl.text = data.address ?? '';
        houseNumberCtrl.text = data.houseNumber ?? '';
        cityCtrl.text = data.city ?? '';
        stateCtrl.text = data.countryState ?? '';
        postalCodeCtrl.text = data.postalCode ?? '';
        countryTitleCtrl.text = data.country ?? '';
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    productController.titleCtrl.clear();
    productController.sizeCtrl.clear();
    productController.brandCtrl.clear();
    productController.categoryCtrl.clear();
    productController.conditionCtrl.clear();
    productController.sellingPriceCtrl.clear();
    productController.descriptionCtrl.clear();
    super.dispose();
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
              Text('         My Sales       '),
            ],
            views: [_createPost(), _myPostList(), _mySalesList()],
            onChange: (int index) {
              if (index == 1) {
                productController.myProduct.value = [];
                productController.getMyProduct();
              } else if(index == 2){
                productController.mySales.value = [];
                productController.getMySales();

              }
            },
          ),
        ));
  }



  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");


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
  bool _isBoost = false;
  bool pickMyLocation = true;
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
                controller: productController.titleCtrl,
                labelText: "Product Title",
                hintText: "Product Title"),

            CustomTextField(
                keyboardType: TextInputType.number,
                controller:productController. sizeCtrl,
                labelText: "Size",
                hintText: "Size"),



            CustomTextField(
                controller: productController.brandCtrl,
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
              controller:productController. categoryCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select category';
                }
                return null;
              },
              suffixIcon: CustomPopupMenu(
                  items: productController.category,
                  onSelected: (p0) {
                    productController.selectedCategoryCtrl.text = p0;
                    final selectCarThis = productController.category
                        .firstWhere((x) => x.id.toString() == p0);
                    productController.categoryCtrl.text = selectCarThis.name.toString();
                    setState(() {});
                  }),
            ),
            CustomTextField(
                controller: productController.conditionCtrl,
                labelText: "Condition",
                hintText: "Condition"),

            CustomTextField(
                keyboardType: TextInputType.number,
                controller: productController.sellingPriceCtrl,
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
                controller: productController.descriptionCtrl,
                labelText: "Description",
                hintText: "Write Description"),







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
                      if (c.types.contains("administrative_area_level_1")) {
                        // This usually represents the state / province / region
                        stateCtrl.text = c.longName;
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


            //
            //
            // Row(
            //   children: [
            //     CircularCheckBox(
            //       size: 20.r,
            //       isChecked: !pickMyLocation,
            //       onChanged: (value) async {
            //         setState(() {
            //           pickMyLocation = !value;
            //         });
            //
            //         List<dynamic> servicePoints = [];
            //         bool isLoading = false;
            //
            //         String basicAuth = 'Basic ${base64Encode(utf8.encode('fb447bde-14d9-4adf-9b23-cab2af16c26c:0b66e82cf1d74f7585b3068bcc961079'))}';
            //
            //         Future<void> fetchServicePoints() async {
            //           setState(() {
            //             isLoading = true;
            //           });
            //
            //           try {
            //             final response = await http.get(Uri.parse(
            //                 'https://stoplight.io/mocks/sendcloud/sendcloud-public-api:v2/299107080/service-points?country=GB'
            //             ), headers: {
            //               'Content-Type' : 'application/json',
            //               'Authorization': basicAuth,
            //               'Accept': 'application/json',
            //             });
            //
            //             if (response.statusCode == 200) {
            //               print("================resopnse ${response.body}");
            //               setState(() {
            //                 var data = json.decode(response.body);
            //                 servicePoints = data; // ✅ Correct assignment
            //                 isLoading = false;
            //               });
            //             } else {
            //               setState(() {
            //                 isLoading = false;
            //               });
            //               print('API Error: ${response.statusCode}');
            //             }
            //           } catch (e) {
            //             setState(() {
            //               isLoading = false;
            //             });
            //             print('Error fetching service points: $e');
            //           }
            //         }
            //
            //
            //         // Fetch data before showing dialog
            //         await fetchServicePoints();
            //
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               title: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   CustomText(text: "Select a Drop-off Point", fontSize: 16.h, fontWeight: FontWeight.w600, color: Colors.black),
            //                   IconButton(
            //                     icon: Icon(Icons.close),
            //                     onPressed: () => Navigator.of(context).pop(),
            //                   ),
            //                 ],
            //               ),
            //               content: SingleChildScrollView(
            //                 child: Column(
            //                   mainAxisSize: MainAxisSize.min,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       'Select a Drop-off Point Near You',
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     TextField(
            //                       decoration: InputDecoration(
            //                         hintText: 'Enter postal code or city',
            //                         border: OutlineInputBorder(),
            //                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                       ),
            //                     ),
            //                     SizedBox(height: 16),
            //                     Text(
            //                       'Available Drop-off Point',
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     SizedBox(height: 12),
            //
            //                     isLoading
            //                         ? Center(child: CircularProgressIndicator())
            //                         : servicePoints.isEmpty
            //                         ? Padding(
            //                       padding: EdgeInsets.all(16),
            //                       child: Center(child: Text('No service points available')),
            //                     )
            //                         : Container(
            //                       constraints: BoxConstraints(
            //                         maxHeight: 340.h,
            //                       ),
            //                       child: ListView.builder(
            //                         shrinkWrap: true,
            //                         physics: AlwaysScrollableScrollPhysics(),
            //                         itemCount: servicePoints.length,
            //                         itemBuilder: (context, index) {
            //                           return Column(
            //                             children: [
            //                               DropOffPointCard(servicePoint: servicePoints[index]),
            //                               SizedBox(height: 8),
            //                             ],
            //                           );
            //                         },
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //     CustomText(
            //         text: "Drop off at a Sendcloud pickup point",
            //         fontSize: 16.h,
            //         color: Colors.black,
            //         left: 10.w,
            //         right: 5.w),
            //   ],
            // ),



            SizedBox(height: 20.h),

            Obx(() =>
               CustomButton(
                  loading: productController.productAddLoading.value,
                  title: "Create a Post",
                  onpress: () {
                    if (forKey.currentState!.validate()) {
                      if (_images.length != 0) {

                        productController.addProduct(
                            context: context,
                            productName: productController.titleCtrl.text,
                            sellingPrice: productController.sellingPriceCtrl.text,
                            condition: productController.conditionCtrl.text,
                            description: productController.descriptionCtrl.text,
                            category: productController.categoryCtrl.text,
                            negotiable: _isChecked,
                            brand: productController.brandCtrl.text,
                            size:productController.sizeCtrl.text,
                            isBoosted: _isBoost,
                            images: _images,
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
                            context, "Please select your product images");
                      }
                    }
                  }),
            ),
            SizedBox(height: 160.h)
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
      productController.aiUploadImage(image: newImages.first);

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
              : Padding(
                padding:  EdgeInsets.only(bottom: 100.h),
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
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

                              // CustomNetworkImage(
                              //     borderRadius: BorderRadius.circular(8.r),
                              //     imageUrl:
                              //         "${ApiConstants.imageBaseUrl}${product.images?[0].image ?? ""}",
                              //     height: 139.h,
                              //     width: 109.w),

                              SizedBox(width: 7.w),

                              // Info Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            textAlign: TextAlign.start,
                                              text: "${product.productName}",
                                              fontWeight: FontWeight.w600,
                                              bottom: 4.h,
                                              color: Colors.black),
                                        ),
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
                                            text: "${product.status?[0].toUpperCase()}${product.status?.substring(1).toLowerCase()}",
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
                                          text: "${CurrencyHelper.getCurrencyPrice(product.sellingPrice.toString())}",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                        text: "Pet Type: ${product.category}",
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
                                      text: "",
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
              ),
    );
  }


  String selected = 'delivery_filled';

  Widget _mySalesList() {
    return Obx(
      () => productController.mySalesLoading.value
          ? ShimmerListView()
          : productController.mySales.isEmpty
              ? NoDataFoundCard()
              : Padding(
                padding:  EdgeInsets.only(bottom: 110.h),
                child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
                    itemCount: productController.mySales.length,
                    itemBuilder: (context, index) {
                      var sales = productController.mySales[index];
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
                                  imageUrl: sales.product?.images?.length == 0 ? "" :
                                      "${ApiConstants.imageBaseUrl}/${sales.product?.images?[0]["image"]}",
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
                                        Expanded(
                                          child: CustomText(
                                            textAlign: TextAlign.start,
                                              text:
                                                  "${sales.product?.productName}",
                                              fontWeight: FontWeight.w600,
                                              bottom: 4.h,
                                              color: Colors.black),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Assets.icons.moneyIconCard.svg(),
                                        SizedBox(width: 4.w),
                                        CustomText(
                                          text: "${CurrencyHelper.getCurrencyPrice(sales.product?.sellingPrice.toString() ?? "0")}",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                        text:
                                            "Pet Type: ${sales.product?.category}",
                                        fontSize: 12.h,
                                        bottom: 4.h,
                                        color: Colors.black),
                                    CustomText(
                                      text:
                                          "Condition: ${sales.product?.condition}",
                                      fontSize: 12.h,
                                      bottom: 4.h,
                                      color: Colors.black,
                                    ),
                                    CustomText(
                                      text: "Brand: ${sales.product?.brand}",
                                      fontSize: 12.h,
                                      color: Colors.black,
                                      bottom: 7.h,
                                    ),

                                    CustomButton(
                                      height: 30.h,
                                        loaderIgnore: true,
                                        fontSize: 12.h,
                                        title: "${sales.status?.replaceAll("_", " ").toLowerCase().capitalizeFirst}", onpress: () {

                                        if(sales.status ==  "delivery_filled"){
                                          //route
                                          Get.toNamed(AppRoutes.shipmentScreen, arguments: {
                                            "productId" : "${sales.product?.id}"
                                          });
                                        }else if(sales.status == "shipment_ready"){
                                          Get.toNamed(AppRoutes.courierScreen, arguments: {
                                            "productId" : "${sales.product?.id}"
                                          });
                                        }

                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ),
    );
  }
}




class DropOffPointCard extends StatelessWidget {
  final Map<String, dynamic> servicePoint;

  const DropOffPointCard({Key? key, required this.servicePoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', servicePoint['name'] ?? 'N/A'),
          SizedBox(height: 8),
          _buildInfoRow('Street', servicePoint['street'] ?? 'N/A'),
          SizedBox(height: 8),
          _buildInfoRow('House Number', servicePoint['house_number']?.toString() ?? 'N/A'),
          SizedBox(height: 8),
          _buildInfoRow('Postal Code', servicePoint['postal_code'] ?? 'N/A'),
          SizedBox(height: 8),
          _buildInfoRow('City', servicePoint['city'] ?? 'N/A'),
          SizedBox(height: 8),
          _buildInfoRow('Opening Hours', _formatOpeningHours(servicePoint['formatted_opening_times'] ?? {})),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          child: Text(
            '$label :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  String _formatOpeningHours(Map<String, dynamic> openingTimes) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> hours = [];

    for (int i = 0; i < days.length; i++) {
      if (openingTimes[i.toString()] != null &&
          openingTimes[i.toString()] is List &&
          (openingTimes[i.toString()] as List).isNotEmpty) {
        hours.add('${days[i]}: ${openingTimes[i.toString()].first}');
      }
    }

    return hours.isNotEmpty ? hours.join(', ') : 'Not available';
  }
}