

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SetDropOffLocationScreen extends StatefulWidget {
  const SetDropOffLocationScreen({super.key});

  @override
  State<SetDropOffLocationScreen> createState() => _SetDropOffLocationScreenState();
}

class _SetDropOffLocationScreenState extends State<SetDropOffLocationScreen> {


  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController postCodeCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();

  FocusNode address1Focus = FocusNode();

  AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  final places = GoogleMapsPlaces(
      apiKey: "AIzaSyA-Iri6x5mzNv45XO3a-Ew3z4nvF4CdYo0");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Set Drop-Off location"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: forKey,
            child: Column(
              children: [
                SizedBox(height: 30.h),

                Assets.images.setDropOffLocation.image(height: 230.h, width: 245.w),

                CustomText(
                  text: "Set Your Drop-off Location",
                  color: AppColors.textColor767676,
                  top: 12.h,
                  bottom: 30.h,
                ),

                /// <<< ============><>>> Login text flied  << < ==============>>>

                // CustomTextField(
                //   controller: addressCtrl,
                //   hintText: "Enter your address",
                //   labelText: "Address"
                // ),

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
                        postCodeCtrl.text = c.longName;
                      }
                      if (c.types.contains("country")) {
                        // countryTitleCtrl.text = c.longName;
                        // countryCodeCtrl.text = c.shortName;



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



                SizedBox(height: 16.h),



                Row(
                  children: [

                    Expanded(child: CustomTextField(controller: cityCtrl, labelText: "City", hintText: "Enter City")),
                    SizedBox(width: 16.w),
                    Expanded(child: CustomTextField(controller: postCodeCtrl, labelText: "Postal Code", hintText: "Enter postal code")),

                  ],
                ),







                SizedBox(height: 60.h),

                Obx(
                      () => CustomButton(
                      loading: authController.forgotLoading.value,
                      title: "Continue",
                      onpress: () {
                        if (forKey.currentState!.validate()) {
                          // authController.forgetPassword(
                              // email: emailCtrl.text.trim());
                        }
                      }),
                ),

                SizedBox(height: 160.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
