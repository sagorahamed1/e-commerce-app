import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controller/product_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../widgets/cachanetwork_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductController productController = Get.put(ProductController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getSingleProduct(id: Get.arguments["index"].toString());
      profileController.getLocalData();
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


                ProductImageSlider(
                  images: productController.singleProduct.value.images
                      ?.map((e) => "${ApiConstants.imageBaseUrl}/${e.image}")
                      .toList() ?? [],
                ),

                //
                // CustomNetworkImage(
                //     height: 216.h,
                //     width: double.infinity,
                //     borderRadius: BorderRadius.circular(10.r),
                //     imageUrl:
                //         "${ApiConstants.imageBaseUrl}/${productController.singleProduct.value.images?[0].image}"),
                //




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


               if(productController.singleProduct.value.user?.id != profileController.id.value)
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Obx(() =>
                           CustomButton(
                              loading: productController.sendOfferLoading.value,
                              title: "Offer Price",
                              onpress: () {
                                productController.sendOffer(
                                    id: productController.singleProduct.value.id.toString(),
                                    price: productController.singleProduct.value.sellingPrice.toString());
                              },
                              fontSize: 12.h),
                        )),
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




class ProductImageSlider extends StatefulWidget {
  final List<String> images;

  const ProductImageSlider({super.key, required this.images});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Auto scroll logic
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.images.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primaryColor,
            dotHeight: 8.h,
            dotWidth: 8.w,
          ),
        ),
      ],
    );
  }
}