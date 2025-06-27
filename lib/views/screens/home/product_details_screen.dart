import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';

import '../../widgets/cachanetwork_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              CustomNetworkImage(
                  height: 216.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10.r),
                  imageUrl:
                  "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773")
          
              ,
              CustomText(text: "Cat Travel Bag (Used)", top: 16.h, bottom: 4, fontSize: 18.h, fontWeight: FontWeight.w500, color: Colors.black),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.watch_later_outlined,
                          size: 14.h),
                      CustomText(
                          text: " Posted 2 hour ago",
                          fontSize: 12.h,
                          color: Color(0xff6F6F6F)),
                    ],
                  ),
          
          
                  CustomText(text: "\$30", fontSize: 17.h, fontWeight: FontWeight.w500, color: Colors.red)
                ],
              ),
          
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Banani, Dhaka, Bangladesh",
                      fontSize: 12.h,
                      color: Color(0xff6F6F6F)),
          
          
                  CustomText(
                      text: "Negotiable",
                      fontSize: 12.h,
                      color: Color(0xff2DA800)),
                ],
              ),
          
          
          
              Padding(
                padding:  EdgeInsets.only(top: 12.h, bottom: 9.h),
                child: Divider(height: 1.h , color: AppColors.textColor767676),
              ),
          
          
              CustomText(text: "Pet Type", color: Colors.black, fontWeight: FontWeight.w500),
              CustomText(color: Color(0xff1C1C1C),text: "• Cat", bottom: 7.h),
          
          
          
              CustomText(text: "Condition", color: Colors.black, fontWeight: FontWeight.w500),
          
              CustomText(color: Color(0xff1C1C1C),text: "• Used"),
              CustomText(color: Color(0xff1C1C1C),text: "• Condition: 60% usable", bottom: 7.h),
          
              CustomText(text: "\$30", fontSize: 17.h, fontWeight: FontWeight.w500, color: Colors.black26,)
          ,
              CustomText(text: "Purchase Price", color: Colors.black, fontWeight: FontWeight.w500, bottom: 7.h),
          
              CustomText(text: "Usage Duration", color: Colors.black, fontWeight: FontWeight.w500),
              CustomText(color: Color(0xff1C1C1C),text: "• Used for 3 months", bottom: 7.h),
          
          
          
              CustomText(text: "Description", color: Colors.black, fontWeight: FontWeight.w500, bottom: 4.h),
          
          
              CustomText(
                  maxline: 50,
                  textAlign: TextAlign.start,
                  bottom: 7.h,
                  color: Color(0xff1C1C1C),
                  text: "Compact and comfy cat travel bag, size Medium. Soft inner lining, breathable mesh windows. Used for only 3 months. Perfect for vet visits or weekend trips. Cleaned and sanitized."),
          
          
          
          
          
              CustomText(text: "Delivery Options", color: Colors.black, fontWeight: FontWeight.w500),
              CustomText(color: Color(0xff1C1C1C),text: "• Courier Delivery Available (buyer Pays)", bottom: 7.h),
          
          
          
          
          
              CustomText(text: "Return & Refund Policy", color: Colors.black, fontWeight: FontWeight.w500),
              CustomText(color: Color(0xff1C1C1C),text: "• Returns accepted within 2 days"),
              CustomText(color: Color(0xff1C1C1C),text: "• Buyer pays return shipping"),
              CustomText(color: Color(0xff1C1C1C),text: "• Refund: Full if item is damaged/misrepresented", bottom: 10.h),
          
          
          
          
          
              CustomText(text: "Seller Info", color: Colors.black, fontWeight: FontWeight.w500, bottom: 6.h),
          
              Row(
                children: [
                  
                  CustomNetworkImage(imageUrl: "", height: 34.h, width: 34.w, boxShape: BoxShape.circle),
          

                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          
                      CustomText(text: " Sarah Rahman", color: Colors.black87),
                      Row(
                        children: [
                          CustomText(text: "⭐ 4.8 | Verified Seller", color: Colors.black87),
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
                      child: CustomButton(title: "Offer Price", onpress: (){}, fontSize: 12.h)),
          
          
                  SizedBox(width: 10.w),
          
                  Expanded(
                      flex: 1,
                      child: CustomButton(title: "Add to Cart", onpress: (){}, fontSize: 12.h)),
          
          
                ],
              ),


              SizedBox(height: 60.h)
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}
