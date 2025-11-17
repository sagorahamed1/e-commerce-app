import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:petattix/controller/purchase_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/views/widgets/cusotom_check_box.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import '../../../controller/product_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class ConfirmPurchaseScreen extends StatefulWidget {
  const ConfirmPurchaseScreen({super.key});

  @override
  State<ConfirmPurchaseScreen> createState() => _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
  PurchaseController purchaseController = Get.put(PurchaseController());

  // TextEditingController companyNameCtrl = TextEditingController();
  // TextEditingController phoneNoCtrl = TextEditingController();
  // TextEditingController postalCodeCtrl = TextEditingController();
  // TextEditingController countryCodeCtrl = TextEditingController();
  // TextEditingController countryIdCtrl = TextEditingController();
  // TextEditingController countryTitleCtrl = TextEditingController();
  // TextEditingController addressLine1Ctrl = TextEditingController();
  // TextEditingController addressLine2Ctrl = TextEditingController();
  // TextEditingController cityCtrl = TextEditingController();
  //
  // FocusNode companyFocus = FocusNode();
  // FocusNode address1Focus = FocusNode();
  // FocusNode address2Focus = FocusNode();
  // FocusNode cityFocus = FocusNode();
  // FocusNode postalFocus = FocusNode();
  // FocusNode phoneFocus = FocusNode();
  // FocusNode countryFocus = FocusNode();
  // FocusNode countryCodeFocus = FocusNode();
  // FocusNode countryIdFocus = FocusNode();
  // FocusNode countryTitleFocus = FocusNode();




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

  final GlobalKey<FormState> forKey = GlobalKey<FormState>();


  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");
  ProductController productController = Get.put(ProductController());


  @override
  void initState() {
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

  bool isSendCloudPoint = false;
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final apiData = productController.dropOffData.value;

    return Scaffold(
      appBar: CustomAppBar(title: "Confirm Purchase"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: forKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10.h),


                    Row(
                      children: [
                        CircularCheckBox(
                          size: 20.r,
                          isChecked: true,
                          onChanged: (value) {},
                        ),
                        CustomText(
                            text: "Deliver to my location",
                            fontSize: 16.h,
                            color: Colors.black,
                            left: 10.w,
                            right: 5.w),
                      ],
                    ),


                    SizedBox(height: 16.h),



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






                Row(
                  children: [
                    CircularCheckBox(
                      size: 20.r,
                      isChecked: isSendCloudPoint,
                      onChanged: (value) {
                        setState(() {
                          isSendCloudPoint = value;

                          if(isSendCloudPoint){
                            Get.toNamed(AppRoutes.dropOffPointScreen, arguments: {
                              "lat" : apiData?.latitude ?? "0",
                              "long" : apiData?.longitude ?? "0",
                              "country" : apiData?.country ?? "bangladesh",
                              "id" : "${data["productId"]}",
                              "postalCode" : apiData?.postalCode.toString() ?? ""
                             });
                          }else{
                            purchaseController.servicePointId = "";
                            setState(() {});

                            ToastMessageHelper.showToastMessage(context, "Your drop-off point removed!");
                          }

                        });
                      },
                    ),
                    CustomText(
                        text: "Pick up from Sendcloud point",
                        fontSize: 16.h,
                        color: Colors.black,
                        left: 10.w,
                        right: 5.w),
                  ],
                ),


                SizedBox(height: 20.h),




                // CustomTextField(
                //   focusNode: companyFocus,
                //   controller: companyNameCtrl,
                //   labelText: "Your Name",
                //   hintText: "Your name",
                // ),
                //
                //
                // CustomText(text: "Address Line 1",
                //     fontWeight: FontWeight.w500,
                //     bottom: 10.h),
                //
                //
                //
                //
                //
                // GooglePlaceAutoCompleteTextField(
                //   focusNode: address1Focus,
                //   textEditingController: addressLine1Ctrl,
                //   googleAPIKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0",
                //   inputDecoration: InputDecoration(
                //     hintText: "Start typing address",
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.transparent, width: 0.05),
                //       borderRadius: BorderRadius.circular(12.r),
                //     ),
                //   ),
                //   boxDecoration: BoxDecoration(
                //     color: const Color(0xFFFFF2E6),
                //     border: Border.all(color: Colors.transparent),
                //     borderRadius: BorderRadius.circular(12.r),
                //   ),
                //   isLatLngRequired: true,
                //   getPlaceDetailWithLatLng: (prediction) async {
                //     final detail = await places.getDetailsByPlaceId(prediction.placeId!);
                //     final comp = detail.result.addressComponents;
                //
                //     for (var c in comp) {
                //       if (c.types.contains("locality")) {
                //         cityCtrl.text = c.longName;
                //       }
                //       if (c.types.contains("postal_code")) {
                //         postalCodeCtrl.text = c.longName;
                //       }
                //       if (c.types.contains("country")) {
                //         countryTitleCtrl.text = c.longName;
                //         countryCodeCtrl.text = c.shortName;
                //
                //         var body = {
                //           "Credentials": {
                //             "APIKey": "5XW2Mnqfz6",
                //             "Password": "oWMmGi2[8n"
                //           }
                //         };
                //
                //         var response = await http.post(
                //           Uri.parse('https://services3.transglobalexpress.co.uk/Country/V2/GetCountries'),
                //           headers: {"Content-Type": "application/json"},
                //           body: jsonEncode(body),
                //         );
                //
                //         if (response.statusCode == 200) {
                //           final data = json.decode(response.body);
                //           final countries = data['Countries'];
                //           final matched = countries.firstWhere(
                //                   (e) => e['CountryCode'] == c.shortName,
                //               orElse: () => null);
                //
                //           print("==========================================res $matched");
                //
                //           if (matched != null) {
                //             countryIdCtrl.text = matched['CountryID'].toString(); // এখানে country ID assign
                //           }
                //         } else {
                //           print("HTTP Error: ${response.statusCode}");
                //         }
                //       }
                //     }
                //   },
                //
                //   itemClick: (prediction) {
                //     addressLine1Ctrl.text = prediction.description ?? "";
                //     addressLine1Ctrl.selection = TextSelection.fromPosition(
                //       TextPosition(offset: prediction.description!.length),
                //     );
                //   },
                // ),
                //
                //
                // SizedBox(height: 10.h),
                //
                //
                // CustomTextField(
                //   focusNode: cityFocus,
                //   controller: cityCtrl,
                //   labelText: "City",
                //   hintText: "City",
                // ),
                // CustomTextField(
                //   focusNode: postalFocus,
                //   controller: postalCodeCtrl,
                //   labelText: "Postal Code",
                //   hintText: "Postal Code",
                // ),
                // CustomTextField(
                //   focusNode: phoneFocus,
                //   controller: phoneNoCtrl,
                //   labelText: "Phone Number",
                //   hintText: "Phone number",
                // ),
                // CustomTextField(
                //   focusNode: countryTitleFocus,
                //   controller: countryTitleCtrl,
                //   labelText: "Country",
                //   hintText: "Country",
                // ),
                // CustomTextField(
                //   focusNode: countryCodeFocus,
                //   controller: countryCodeCtrl,
                //   labelText: "Country Code",
                //   hintText: "Country Code",
                // ),
                // CustomTextField(
                //   focusNode: countryIdFocus,
                //   controller: countryIdCtrl,
                //   labelText: "Country Id",
                //   hintText: "Country Id",
                // ),
                //
                //








                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                          title: "Cancel",
                          onpress: () {
                            Get.back();
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
                      child: Obx(() =>
                         CustomButton(
                           loading: purchaseController.createDeliveryLoading.value,
                            // loaderIgnore: true,
                            title: "Confirm",
                            onpress: () {
                              print("==================tapped");
                              if (forKey.currentState!.validate()){
                                purchaseController.createDelivery(
                                  addressOne: addressLine1Ctrl.text,
                                    city: cityCtrl.text,
                                    country: countryTitleCtrl.text,
                                    countryState: stateCtrl.text,
                                    houseNumber: houseNumberCtrl.text,
                                    postalCode: postalCodeCtrl.text,
                                    companyName: houseNumberCtrl.text,
                                    productId: data["productId"] ?? "",
                                    context: context);
                              }


                            },
                            fontSize: 11.h),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

