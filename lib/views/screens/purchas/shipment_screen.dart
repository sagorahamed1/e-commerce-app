import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:petattix/controller/purchase_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key});

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  PurchaseController purchaseController = Get.put(PurchaseController());
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController phoneNoCtrl = TextEditingController();
  TextEditingController postalCodeCtrl = TextEditingController();
  TextEditingController countryCodeCtrl = TextEditingController();
  TextEditingController countryIdCtrl = TextEditingController();
  TextEditingController countryTitleCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController addressLine2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  TextEditingController weightCtrl = TextEditingController();
  TextEditingController widthCtrl = TextEditingController();
  TextEditingController lengthCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();

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
  FocusNode weightFocus = FocusNode();
  FocusNode widthFocus = FocusNode();
  FocusNode lengthFocus = FocusNode();
  FocusNode heightFocus = FocusNode();

  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(title: "Shipment"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: forKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                CustomTextField(
                  focusNode: companyFocus,
                  controller: companyNameCtrl,
                  labelText: "Your Name",
                  hintText: "Your name",
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

                          if (matched != null) {
                            countryIdCtrl.text = matched['CountryID'].toString();
                          }
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
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        height: 42.h,
                          title: "Cancel",
                          onpress: () {},
                          color: Colors.transparent,
                          fontSize: 10.h,
                          loaderIgnore: true,
                          boderColor: AppColors.primaryColor,
                          titlecolor: AppColors.primaryColor),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 1,
                      child: Obx(() =>
                         CustomButton(
                           height: 42.h,
                            loading: purchaseController.createCollectionLoading.value,
                            title: "Confirm",
                            onpress: () {

                              if(forKey.currentState!.validate()){

                                var shipmentData = {
                                  "companyName": companyNameCtrl.text,
                                  "addressLineOne": addressLine1Ctrl.text,
                                  "addressLineTwo": addressLine2Ctrl.text,
                                  "city": cityCtrl.text,
                                  "postcode": postalCodeCtrl.text,
                                  "telephoneNumber": phoneNoCtrl.text,
                                  "country_id": int.parse(countryIdCtrl.text),
                                  "country_code": countryCodeCtrl.text,
                                  "country": countryTitleCtrl.text,
                                  "Weight": int.parse(weightCtrl.text),
                                  "Width": int.parse(widthCtrl.text),
                                  "Length": int.parse(lengthCtrl.text),
                                  "Height": int.parse(heightCtrl.text),
                                };


                                purchaseController.createCollection(
                                  productId: data["productId"],
                                  data: shipmentData,
                                  context: context,
                                );
                              }


                            },
                            fontSize: 10.h),
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
