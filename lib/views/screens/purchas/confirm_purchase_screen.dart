import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_text.dart';

import '../../../controller/product_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ConfirmPurchaseScreen extends StatefulWidget {
   ConfirmPurchaseScreen({super.key});

  @override
  State<ConfirmPurchaseScreen> createState() => _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {

  ProductController productController = Get.put(ProductController());

  TextEditingController deliveryAddress = TextEditingController();

  TextEditingController heightCtrl = TextEditingController();
  TextEditingController widthCtrl = TextEditingController();
  TextEditingController lengthCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController postalCodeCtrl = TextEditingController();
  TextEditingController countryCodeCtrl = TextEditingController();
  TextEditingController countryIdCtrl = TextEditingController();
  TextEditingController countryTitleCtrl = TextEditingController();
  TextEditingController addressLine1Ctrl = TextEditingController();
  TextEditingController addressLine2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  @override
  void initState() {
    deliveryAddress.text = "Mohakhali, Dhaka, Bangladesh";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm Purchase"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl:
                      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                  height: 95.h,
                  width: 80.w,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Cat Travel Bag (Used)",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    CustomText(text: "30\$", fontSize: 18.h, color: Colors.red),
                    Row(
                      children: [
                        CustomNetworkImage(
                            imageUrl: "https://i.pravatar.cc/150?img=3",
                            height: 34.h,
                            width: 34.w,
                            boxShape: BoxShape.circle),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: " Sarah Rahman", color: Colors.black87),
                            Row(
                              children: [
                                CustomText(
                                    text: "⭐ 4.8 | Verified Seller",
                                    color: Colors.black87),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Delivery Address", fontSize: 16.h, color: Colors.black),
                CustomText(text: "Edit", color: Colors.red),
              ],
            ),
            TextField(
              controller: deliveryAddress,
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),



            CustomTextField(
                controller: cityCtrl,
                labelText: "City",
                hintText: "City"),


            CustomTextField(
              keyboardType: TextInputType.number,
                controller: heightCtrl,
                labelText: "Purcell Height CM",
                hintText: "Purcell Height CM"),
            CustomTextField(
              keyboardType: TextInputType.number,
                controller: widthCtrl,
                labelText: "Purcell Width CM",
                hintText: "Purcell Width CM"),
            CustomTextField(
              keyboardType: TextInputType.number,
                controller: lengthCtrl,
                labelText: "Purcell Length CM",
                hintText: "Purcell Length CM"),
            CustomTextField(
              keyboardType: TextInputType.number,
                controller: weightCtrl,
                labelText: "Purcell Weight KG",
                hintText: "Purcell Weight KG"),




            CustomTextField(
              controller: countryTitleCtrl,
              labelText: "Country",
              hintText: "Country",
              onTap: () {
                productController.isListVisible.value = true;
              },
              onChanged: (value) {
                productController.searchCountry(value);
              },
            ),

            Obx(() {
              if (!productController.isListVisible.value) {
                return const SizedBox.shrink();
              }

              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.grey, width: 0.05)
                ),
                child: ListView.builder(
                  itemCount: productController.filteredCountry.length,
                  itemBuilder: (context, index) {
                    final country = productController.filteredCountry[index];
                    return GestureDetector(
                      onTap: () {
                        countryTitleCtrl.text = country.title;
                        countryCodeCtrl.text = country.countryCode;
                        countryIdCtrl.text = country.countryId.toString();
                        productController.isListVisible.value = false; // close list
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(country.title),
                      ),
                    );
                  },
                ),
              );
            }),


            CustomTextField(
                controller: addressLine1Ctrl,
                labelText: "Address line 1",
                hintText: "Address line 1"),



            CustomTextField(
                controller: addressLine2Ctrl,
                labelText: "Address line 2",
                hintText: "Address line 2"),


            CustomTextField(
              keyboardType: TextInputType.number,
                controller: postalCodeCtrl,
                labelText: "Postal Code",
                hintText: "Postal Code"),




            // CustomText(
            //   text: "Delivery Methods",
            //   fontSize: 16.h,
            //   color: Colors.black,
            //   top: 10.h,
            // ),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "•  Courier delivery (\$15)",
            //     bottom: 7.h),
            // Divider(),
            // CustomText(
            //   text: "Payment Methods",
            //   fontSize: 16.h,
            //   color: Colors.black,
            //   top: 10.h,
            // ),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "•  Pay via PetAttix (Escrow) (Recommended)",
            //     bottom: 7.h),
            // Divider(),
            // CustomText(
            //   text: "Refund & Return Policy (Collapsible Box)",
            //   fontSize: 16.h,
            //   color: Colors.black,
            //   top: 10.h,
            // ),
            // CustomText(
            //     text: "refund Available", color: Colors.black, fontSize: 13.h),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "• If item is damaged, fake, or not as described",
            //     bottom: 7.h,
            //     fontSize: 12.h,
            //     top: 8.h),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "• Buyer pays return shipping",
            //     bottom: 7.h,
            //     fontSize: 12.h),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "• Full refund processed after seller confirms return",
            //     bottom: 7.h,
            //     fontSize: 12.h),
            // CustomText(
            //     color: Color(0xff1C1C1C),
            //     text: "• No returns for “change of mind” or personal dislike",
            //     bottom: 7.h,
            //     fontSize: 12.h),
            // CustomText(
            //     text: "View Full Return Policy..",
            //     fontSize: 15.h,
            //     color: AppColors.primaryColor,
            //     top: 10.h,
            //     bottom: 120.h),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      height: 26.h,
                      title: "Cancel",
                      onpress: () {},
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
                      loading: false,
                      loaderIgnore: true,
                      height: 26.h,
                      title: "Confirm",
                      onpress: () {
                        Get.toNamed(AppRoutes.makePayment);
                      },
                      fontSize: 11.h),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
