import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:petattix/controller/purchase_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_text.dart';
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

  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController phoneNoCtrl = TextEditingController();
  TextEditingController postalCodeCtrl = TextEditingController();
  TextEditingController countryCodeCtrl = TextEditingController();
  TextEditingController countryIdCtrl = TextEditingController();
  TextEditingController countryTitleCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController addressLine2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  FocusNode companyFocus = FocusNode();
  FocusNode address1Focus = FocusNode();
  FocusNode address2Focus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode postalFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode countryCodeFocus = FocusNode();
  FocusNode countryIdFocus = FocusNode();
  FocusNode countryTitleFocus = FocusNode();


  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm Purchase"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                focusNode: companyFocus,
                controller: companyNameCtrl,
                labelText: "Company Name",
                hintText: "Company name",
              ),


              CustomText(text: "Address Line 1",
                  fontWeight: FontWeight.w500,
                  bottom: 10.h),





              GooglePlaceAutoCompleteTextField(
                focusNode: address1Focus,
                textEditingController: addressLine1Ctrl,
                googleAPIKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0",
                inputDecoration: InputDecoration(
                  hintText: "Start typing address",
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
                // getPlaceDetailWithLatLng: (prediction) async {
                //   final detail = await places.getDetailsByPlaceId(prediction.placeId!);
                //   final comp = detail.result.addressComponents;
                //
                //
                //   for (var c in comp) {
                //     if (c.types.contains("locality")) {
                //       cityCtrl.text = c.longName;
                //     }
                //     if (c.types.contains("postal_code")) {
                //       postalCodeCtrl.text = c.longName;
                //     }
                //     if (c.types.contains("country")) {
                //       countryTitleCtrl.text = c.longName;
                //       countryCodeCtrl.text = c.shortName;
                //
                //
                //       var body = {
                //         "Credentials": {
                //           "APIKey": "5XW2Mnqfz6",
                //           "Password": "oWMmGi2[8n"
                //         }
                //       };
                //
                //
                //       var response = await http.post(Uri.parse('https://services3.transglobalexpress.co.uk//Country/V2/GetCountries'), body: jsonEncode(body));
                //
                //       if (response.statusCode == 200) {
                //         final data = json.decode(response.body);
                //         final countries = data['Countries'];
                //         final matched = countries.firstWhere((e) => e['CountryCode'] == c.shortName, orElse: () => null);
                //         print("==========================================res ${matched} == ${response.body}");
                //           countryIdCtrl.text = matched;
                //       }
                //
                //
                //     }
                //   }
                //
                //
                //
                //
                // },


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
                      countryCodeCtrl.text = c.shortName;

                      var body = {
                        "Credentials": {
                          "APIKey": "5XW2Mnqfz6",
                          "Password": "oWMmGi2[8n"
                        }
                      };

                      var response = await http.post(
                        Uri.parse('https://services3.transglobalexpress.co.uk/Country/V2/GetCountries'),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode(body),
                      );

                      if (response.statusCode == 200) {
                        final data = json.decode(response.body);
                        final countries = data['Countries'];
                        final matched = countries.firstWhere(
                                (e) => e['CountryCode'] == c.shortName,
                            orElse: () => null);

                        print("==========================================res $matched");

                        if (matched != null) {
                          countryIdCtrl.text = matched['CountryID'].toString(); // এখানে country ID assign
                        }
                      } else {
                        print("HTTP Error: ${response.statusCode}");
                      }
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
                focusNode: address2Focus,
                controller: addressLine2Ctrl,
                labelText: "Address line 2",
                hintText: "Address line 2",
              ),

              CustomTextField(
                focusNode: cityFocus,
                controller: cityCtrl,
                labelText: "City",
                hintText: "City",
              ),
              CustomTextField(
                focusNode: postalFocus,
                controller: postalCodeCtrl,
                labelText: "Postal Code",
                hintText: "Postal Code",
              ),
              CustomTextField(
                focusNode: phoneFocus,
                controller: phoneNoCtrl,
                labelText: "Phone Number",
                hintText: "Phone number",
              ),
              CustomTextField(
                focusNode: countryTitleFocus,
                controller: countryTitleCtrl,
                labelText: "Country",
                hintText: "Country",
              ),
              CustomTextField(
                focusNode: countryCodeFocus,
                controller: countryCodeCtrl,
                labelText: "Country Code",
                hintText: "Country Code",
              ),
              CustomTextField(
                focusNode: countryIdFocus,
                controller: countryIdCtrl,
                labelText: "Country Id",
                hintText: "Country Id",
              ),

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
                    child: CustomButton(
                        loaderIgnore: true,
                        title: "Confirm",
                        onpress: () {
                          print("==================tapped");
                          purchaseController.createDelivery(
                              companyName: companyNameCtrl.text,
                              country: countryTitleCtrl.text,
                              countryId: countryIdCtrl.text,
                              countryCode: countryCodeCtrl.text,
                              city: cityCtrl.text,
                              addressOne: addressLine1Ctrl.text,
                              addressTow: addressLine2Ctrl.text,
                              phoneNumber: phoneNoCtrl.text,
                              postCode: postalCodeCtrl.text,
                              productId: data["productId"] ?? "",
                              context: context);
                          // Get.toNamed(AppRoutes.makePayment);
                        },
                        fontSize: 11.h),
                  ),
                ],
              ),
              SizedBox(height: 200.h),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:petattix/core/app_constants/app_colors.dart';
// import 'package:petattix/core/config/app_route.dart';
// import 'package:petattix/views/widgets/custom_app_bar.dart';
// import '../../../controller/product_controller.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_text_field.dart';
//
// class ConfirmPurchaseScreen extends StatefulWidget {
//    ConfirmPurchaseScreen({super.key});
//
//   @override
//   State<ConfirmPurchaseScreen> createState() => _ConfirmPurchaseScreenState();
// }
//
// class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
//
//   ProductController productController = Get.put(ProductController());
//
//
//
//   TextEditingController companyNameCtrl = TextEditingController();
//   TextEditingController phoneNoCtrl = TextEditingController();
//   TextEditingController postalCodeCtrl = TextEditingController();
//   TextEditingController countryCodeCtrl = TextEditingController();
//   TextEditingController countryIdCtrl = TextEditingController();
//   TextEditingController countryTitleCtrl = TextEditingController();
//   TextEditingController addressLine1Ctrl = TextEditingController();
//   TextEditingController addressLine2Ctrl = TextEditingController();
//   TextEditingController cityCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Confirm Purchase"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Row(
//               //   children: [
//               //     CustomNetworkImage(
//               //       imageUrl:
//               //           "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
//               //       height: 95.h,
//               //       width: 80.w,
//               //       borderRadius: BorderRadius.circular(8.r),
//               //     ),
//               //     SizedBox(width: 8.w),
//               //     Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         CustomText(
//               //             text: "Cat Travel Bag (Used)",
//               //             fontSize: 18.h,
//               //             fontWeight: FontWeight.w500,
//               //             color: Colors.black),
//               //         CustomText(text: "30\$", fontSize: 18.h, color: Colors.red),
//               //         Row(
//               //           children: [
//               //             CustomNetworkImage(
//               //                 imageUrl: "https://i.pravatar.cc/150?img=3",
//               //                 height: 34.h,
//               //                 width: 34.w,
//               //                 boxShape: BoxShape.circle),
//               //             SizedBox(width: 10.w),
//               //             Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 CustomText(
//               //                     text: " Sarah Rahman", color: Colors.black87),
//               //                 Row(
//               //                   children: [
//               //                     CustomText(
//               //                         text: "⭐ 4.8 | Verified Seller",
//               //                         color: Colors.black87),
//               //                   ],
//               //                 ),
//               //               ],
//               //             )
//               //           ],
//               //         ),
//               //       ],
//               //     )
//               //   ],
//               // ),
//
//
//
//
//               CustomTextField(controller: companyNameCtrl, labelText: "Company Name", hintText: "Company name"),
//
//
//               CustomTextField(
//                   controller: addressLine1Ctrl,
//                   labelText: "Address line 1",
//                   hintText: "Address line 1"),
//
//
//
//               CustomTextField(
//                   controller: addressLine2Ctrl,
//                   labelText: "Address line 2",
//                   hintText: "Address line 2"),
//
//
//
//               CustomTextField(
//                   controller: cityCtrl,
//                   labelText: "City",
//                   hintText: "City"),
//
//
//
//
//               CustomTextField(controller: postalCodeCtrl, labelText: "Post Code", hintText: "Post code"),
//               CustomTextField(controller: phoneNoCtrl, labelText: "Phone Number", hintText: "Phone number"),
//
//               CustomTextField(
//                 controller: countryTitleCtrl,
//                 labelText: "Country",
//                 hintText: "Country",
//                 onTap: () {
//                   productController.isListVisible.value = true;
//                 },
//                 onChanged: (value) {
//                   productController.searchCountry(value);
//                 },
//               ),
//
//               Obx(() {
//                 if (!productController.isListVisible.value) {
//                   return const SizedBox.shrink();
//                 }
//
//                 if (productController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 return Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.black12,
//                     border: Border.all(color: Colors.grey, width: 0.05)
//                   ),
//                   child: ListView.builder(
//                     itemCount: productController.filteredCountry.length,
//                     itemBuilder: (context, index) {
//                       final country = productController.filteredCountry[index];
//                       return GestureDetector(
//                         onTap: () {
//                           countryTitleCtrl.text = country.title;
//                           countryCodeCtrl.text = country.countryCode;
//                           countryIdCtrl.text = country.countryId.toString();
//                           productController.isListVisible.value = false; // close list
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(country.title),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }),
//
//
//
//               CustomTextField(
//                   keyboardType: TextInputType.number,
//                   controller: countryIdCtrl,
//                   labelText: "Country Id",
//                   hintText: "Country Id"),
//
//
//
//               CustomTextField(
//                 keyboardType: TextInputType.number,
//                   controller: postalCodeCtrl,
//                   labelText: "Postal Code",
//                   hintText: "Postal Code"),
//
//
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: CustomButton(
//                         title: "Cancel",
//                         onpress: () {},
//                         color: Colors.transparent,
//                         fontSize: 11.h,
//                         loaderIgnore: true,
//                         boderColor: AppColors.primaryColor,
//                         titlecolor: AppColors.primaryColor),
//                   ),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     flex: 1,
//                     child: CustomButton(
//                         loading: false,
//                         loaderIgnore: true,
//                         title: "Confirm",
//                         onpress: () {
//                           Get.toNamed(AppRoutes.makePayment);
//                         },
//                         fontSize: 11.h),
//                   ),
//                 ],
//               ),
//
//
//               SizedBox(height: 200.h)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


