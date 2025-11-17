import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;

import '../../../../controller/auth_controller.dart';
import '../../../../controller/product_controller.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SetDropOffLocationScreen extends StatefulWidget {
  const SetDropOffLocationScreen({super.key});

  @override
  State<SetDropOffLocationScreen> createState() => _SetDropOffLocationScreenState();
}

class _SetDropOffLocationScreenState extends State<SetDropOffLocationScreen> {


  AuthController authController = Get.find<AuthController>();


  TextEditingController postalCodeCtrl = TextEditingController();
  TextEditingController houseNumberCtrl = TextEditingController();
  TextEditingController countryTitleCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();

  FocusNode address1Focus = FocusNode();
  FocusNode postalFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode countryTitleFocus = FocusNode();
  FocusNode houseNumberFocus = FocusNode();
  FocusNode stateFocus = FocusNode();

  final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  final places = GoogleMapsPlaces(apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");

  Map<String, dynamic>? addressBody;
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

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Set Drop-Off Location"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: forKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Assets.images.setDropOffLocation.image(height: 185.h, width: 185.w),
                CustomText(
                  text: "Set Your Drop-off Location",
                  color: AppColors.textColor767676,
                  top: 12.h,
                  bottom: 16.h,
                ),

                /// Address autocomplete
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Address",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    bottom: 10.h,
                  ),
                ),

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
                      final geometry = detail.result.geometry;

                      String street = '';
                      String city = '';
                      String state = '';
                      String postalCode = '';
                      String country = '';
                      String countryCode = '';
                      String houseNumber = '';

                      // ✅ Correct address component extraction
                      for (var c in comp) {
                        if (c.types.contains('street_number')) {
                          houseNumber = c.longName;
                        } else if (c.types.contains('route')) {
                          street = c.longName;
                        } else if (c.types.contains('locality')) {
                          city = c.longName;
                        } else if (c.types.contains('administrative_area_level_1')) {
                          state = c.longName;
                        } else if (c.types.contains('postal_code')) {
                          postalCode = c.longName;
                        } else if (c.types.contains('country')) {
                          country = c.longName;
                          countryCode = c.shortName;
                        }
                      }

                      // ✅ Update controllers with extracted data
                      setState(() {
                        // addressLine1Ctrl.text =
                        // '${houseNumber.isNotEmpty ? '$houseNumber ' : ''}$street';
                        houseNumberCtrl.text = houseNumber;
                        cityCtrl.text = city;
                        stateCtrl.text = state;
                        postalCodeCtrl.text = postalCode;
                        countryTitleCtrl.text = countryCode;

                        addressBody = {
                          "address": addressLine1Ctrl.text.trim(),
                          "house_number": houseNumber,
                          "address_2": "",
                          "city": city,
                          "country": countryCode,
                          "postal_code": postalCode,
                          "country_state": state,
                          "latitude": geometry?.location.lat,
                          "longitude": geometry?.location.lng,
                        };
                      });

                      print("📦 Address Body Ready: ${jsonEncode(addressBody)}");
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

                SizedBox(height: 60.h),

                Obx(
                      () => CustomButton(
                    loading: authController.setDropOfLocationLoading.value,
                    title: data["screenType"] == "edit" ? "Change Drop-off Location" : "Continue",
                    // onpress: () async {
                    //   if (forKey.currentState!.validate()) {
                    //     if (addressBody == null) {
                    //       Get.snackbar("Error", "Please select a valid address first.");
                    //       return;
                    //     }
                    //
                    //     authController.setDropOfLocation(data: addressBody, screenType: "${data["screenType"]}");
                    //
                    //
                    //   }
                    // },

                        onpress: () async {
                          if (forKey.currentState!.validate()) {
                            // ✅ Always rebuild addressBody from current field values
                            addressBody = {
                              "address": addressLine1Ctrl.text.trim(),
                              "house_number": houseNumberCtrl.text.trim(),
                              "address_2": "",
                              "city": cityCtrl.text.trim(),
                              "country": countryTitleCtrl.text.trim(),
                              "postal_code": postalCodeCtrl.text.trim(),
                              "country_state": stateCtrl.text.trim(),
                              "latitude": addressBody?["latitude"], // keep previous lat/lng if available
                              "longitude": addressBody?["longitude"],
                            };

                            // If still no lat/lng (manual entry only), just send null
                            addressBody!["latitude"] ??= null;
                            addressBody!["longitude"] ??= null;

                            authController.setDropOfLocation(
                              data: addressBody,
                              screenType: "${data["screenType"]}",
                            );
                          }
                        },

                      ),
                ),

                SizedBox(height: 160.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
