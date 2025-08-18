import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

import '../../../controller/product_controller.dart';
import '../../widgets/custom_product_card.dart';
import '../../widgets/shimmer_grid_view.dart';

class AllProductScreen extends StatefulWidget {
  AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  ProductController productController = Get.put(ProductController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getAllProduct();
    });

    super.initState();
  }

  double minPrice = 5;
  double maxPrice = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SizedBox(
        width: 300.w,
        child: Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [

                CustomText(text: "Filler", fontSize: 20.h, fontWeight: FontWeight.w600, color: Color(0xff592B00)),


                 SizedBox(height: 20.h),

                /// Category

                CustomText(text: "Category", color: Colors.black, textAlign: TextAlign.start),

                SizedBox(height: 10.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    categoryButton("Cat", true),
                    categoryButton("Dog"),
                    categoryButton("Bird"),
                    categoryButton("Fish"),
                    categoryButton("All"),
                  ],
                ),

                 SizedBox(height: 25.h),

                /// Usability
                CustomText(text: "Usability", color: Colors.black, textAlign: TextAlign.start),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    categoryButton("100%", true),
                    categoryButton("80%-99%"),
                    categoryButton("60%-79%"),
                    categoryButton("<60%"),
                    categoryButton("All"),
                  ],
                ),

                 SizedBox(height: 25.h),

                /// Price Range
                CustomText(text: "Price Range", color: Colors.black, textAlign: TextAlign.start),
                 SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${minPrice.toInt()} \$"),
                    Text("${maxPrice.toInt()} \$"),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.orange,
                    inactiveTrackColor: Colors.grey[300],
                    thumbColor: Colors.orange,
                  ),
                  child: RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    onChanged: (values) {
                      setState(() {
                        minPrice = values.start;
                        maxPrice = values.end;
                      });
                    },
                  ),
                ),

                 SizedBox(height: 80.h),

                /// Apply Button
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  child: CustomButton(
                      title: "Apply", onpress: () {
                        productController.allProduct.value = [];
                        productController.getAllProduct(price: "${minPrice.ceil()}-${maxPrice.ceil()}");
                  }),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: CustomAppBar(title: "All Product"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 300.w,
                  child: CustomTextField(
                    controller: searchCtrl,
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: "Search For Pet Product",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
                    child: Assets.icons.filterIcon.svg(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: AnimationLimiter(
                child: Obx( () => productController.allProductLoading.value ? ShimmerGridView() :
                   GridView.builder(
                    itemCount: productController.allProduct.length,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.868,
                    ),
                    itemBuilder: (context, index) {
                      var product = productController.allProduct[index];
                      return CustomProductCard(
                        image: "${product.images?[0].image}",
                        index: index,
                        isFavorite: true,
                        title: "${product.productName}",
                        address: "${product.addressLine1 ?? "N/A"}",
                        price: "${product.sellingPrice}",
                        onTap: () {Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                          "index" : index
                        });},

                        favoriteOnTap: () {
                          productController.toggleFavourite(id: product.id.toString());
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget categoryButton(String text, [bool selected = false]) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.orange : Colors.transparent,
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(text: text, color: selected ? Colors.white : Colors.orange, left: 32.w, right: 32.w, top: 4.h, bottom: 4.h)
    );
  }

}

