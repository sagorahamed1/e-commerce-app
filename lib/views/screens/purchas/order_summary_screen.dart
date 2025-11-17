


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/product_controller.dart';

import '../../../model/shipping_price_data.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  ProductController controller = Get.put(ProductController());
  // final data = Get.arguments;


  @override
  void initState() {
    var data = Get.arguments;
    controller.fetchShippingPricing(
      productId: "${data["productId"]}",
      shippingId: "${data["shippingId"]}",
      context: context
    );

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var routeData = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.h),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: "Order Summary",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.shippingLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {

          return Center(
            child: Text(
              "Shipping method is not valid \n Please go back and try another!",
              style: TextStyle(color: Colors.black, fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
          );
        }

        final data = controller.shippingData.value;
        if (data == null) {
          return const Center(child: Text("No shipping data found"));
        }

        return _buildOrderSummary(data, routeData);
      }),
    );
  }

  Widget _buildOrderSummary(ShippingPricingData data, var routeData) {


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 24.h),
                _buildSectionTitle("Shipping Details"),
                SizedBox(height: 8.h),
                _buildShippingDetails("${data.shippingMethodInfo?.name}", "${data.shippingMethodInfo?.carrier}", "${data.pricingInfo?.total.toString()}"),
                SizedBox(height: 24.h),
                _buildSectionTitle("Buyer Protection"),
                 _buildBuyerProtection(data.pricingInfo?.productProtectionFee?.toDouble() ?? 0.0, ),
                SizedBox(height: 8.h),
                 // _buildBuyerProtection(data.pricing),
                SizedBox(height: 24.h),
                _buildSectionTitle("Total Summary"),
                SizedBox(height: 8.h),


                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                     _summaryRow("Delivery Charge", "${double.parse(data.pricingInfo?.deliveryCharge.toString() ?? "").toStringAsFixed(2)}"),
                      _summaryRow("Delivery Protection Fee", "${double.parse(data.pricingInfo?.deliveryProtectionFee.toString() ?? "").toStringAsFixed(2)}"),
                      _summaryRow("Product Price", "${double.parse(data.pricingInfo?.productPrice.toString() ?? "").toStringAsFixed(2)}"),
                      _summaryRow("Production Fee", "${double.parse(data.pricingInfo?.productProtectionFee.toString() ?? "").toStringAsFixed(2)}"),

                      const Divider(),
                      _summaryRow("Production Fee", "${double.parse(data.pricingInfo?.total.toString() ?? "").toStringAsFixed(2)}", isBold: true),

                    ],
                  ),
                )

              ],
            ),
          ),
          Obx(() =>
             CustomButton(
              loading: controller.confirmPaymentLoading.value,
              title: "Make Payment",
              onpress: () {
                controller.confirmPayment(context: context, productId: routeData["productId"], shippingId: routeData["shippingId"]);
                print("💰 Make Payment Clicked");
              },
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) => CustomText(
    textAlign: TextAlign.start,
    text: title,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  Widget _buildShippingDetails(
      String name, String carrier, String cost) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Method: ${name}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Carrier: ${carrier}"),
          Text("Shipping Cost: GBP ${double.parse(cost).toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildBuyerProtection(double protectionFee) {
    return Text("Buyer Protection Fee: GBP ${protectionFee.toStringAsFixed(2)}");
  }


  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w400)),
          Text(value,
              style: TextStyle(
                  color: isBold ? Colors.green : Colors.black,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }
}






