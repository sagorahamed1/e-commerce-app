import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';

import '../../../controller/product_controller.dart';
import '../../widgets/cachanetwork_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getSingleProduct(id: Get.arguments["index"].toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                    height: 216.h,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(10.r),
                    imageUrl:
                        "${ApiConstants.imageBaseUrl}/${productController.singleProduct.value.images?[0].image}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text:
                            "${productController.singleProduct.value.productName}",
                        top: 16.h,
                        bottom: 4,
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          productController.toggleFavourite(
                              id: productController.singleProduct.value.id
                                  .toString());
                        },
                        child: Icon(
                          productController.singleProduct.value.isFavorite ??
                                  false
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: productController
                                      .singleProduct.value.isFavorite ??
                                  false
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.watch_later_outlined, size: 14.h),
                        SizedBox(
                          width: 150.w,
                          child: CustomText(
                              textAlign: TextAlign.start,
                              text:
                                  " ${TimeFormatHelper.formatDate(productController.singleProduct.value.createdAt ?? DateTime.now())} ${TimeFormatHelper.timeWithAMPMLocalTime(productController.singleProduct.value.createdAt ?? DateTime.now())}",
                              fontSize: 12.h,
                              color: Color(0xff6F6F6F)),
                        ),
                      ],
                    ),
                    CustomText(
                        text:
                            "\$${productController.singleProduct.value.sellingPrice}",
                        fontSize: 17.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.red)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text:
                            "${productController.singleProduct.value.addressLine1 ?? "N/A"}",
                        fontSize: 12.h,
                        color: Color(0xff6F6F6F)),
                    CustomText(
                        text: productController
                                    .singleProduct.value.isNegotiable ==
                                false
                            ? "Fixed"
                            : "Negotiable",
                        fontSize: 12.h,
                        color: Color(0xff2DA800)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 9.h),
                  child: Divider(height: 1.h, color: AppColors.textColor767676),
                ),
                CustomText(
                    text: "Pet Type",
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                CustomText(
                    color: Color(0xff1C1C1C),
                    text: "• ${productController.singleProduct.value.category}",
                    bottom: 7.h),
                CustomText(
                    text: "Condition",
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                CustomText(
                    color: Color(0xff1C1C1C),
                    text:
                        "• ${productController.singleProduct.value.condition}"),
                CustomText(
                    top: 7.h,
                    text: "Purchase Price",
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                CustomText(
                  text:
                      "\$${productController.singleProduct.value.purchasingPrice}",
                  fontSize: 17.h,
                  fontWeight: FontWeight.w500,
                  color: Colors.black26,
                  bottom: 7.h,
                ),
                CustomText(
                    text: "Description",
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    bottom: 4.h),
                CustomText(
                    maxline: 50,
                    textAlign: TextAlign.start,
                    bottom: 7.h,
                    color: Color(0xff1C1C1C),
                    text:
                        "${productController.singleProduct.value.description}"),
                CustomText(
                    text: "Return & Refund Policy",
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                CustomText(
                    color: Color(0xff1C1C1C),
                    text: "• Returns accepted within 2 days"),
                CustomText(
                    color: Color(0xff1C1C1C),
                    text: "• Buyer pays return shipping"),
                CustomText(
                    color: Color(0xff1C1C1C),
                    text: "• Refund: Full if item is damaged/misrepresented",
                    bottom: 10.h),
                CustomText(
                    text: "Seller Info",
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    bottom: 6.h),
                Row(
                  children: [
                    CustomNetworkImage(
                        imageUrl:
                            "${ApiConstants.imageBaseUrl}/${productController.singleProduct.value.user?.image}",
                        height: 34.h,
                        width: 34.w,
                        boxShape: BoxShape.circle),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text:
                                " ${productController.singleProduct.value.user?.firstName} ${productController.singleProduct.value.user?.lastName}",
                            color: Colors.black87),
                        Row(
                          children: [
                            CustomText(
                                text: "⭐  | Verified Seller",
                                color: Colors.black87),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CustomButton(
                            title: "Offer Price",
                            onpress: () {},
                            fontSize: 12.h)),
                    SizedBox(width: 10.w),
                    Expanded(
                        flex: 1,
                        child: CustomButton(
                            title: "Add to Cart",
                            onpress: () {},
                            fontSize: 12.h)),
                  ],
                ),
                SizedBox(height: 60.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
