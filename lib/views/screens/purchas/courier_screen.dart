import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/helper/currency_get_helper.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';

import '../../../controller/purchase_controller.dart';



class CourierScreen extends StatefulWidget {
  const CourierScreen({super.key});

  @override
  State<CourierScreen> createState() => _CourierScreenState();
}

class _CourierScreenState extends State<CourierScreen> {
  int selectedIndex = -1;
  PurchaseController purchaseController = Get.put(PurchaseController());


  @override
  void initState() {
    var productId = Get.arguments["productId"];
    purchaseController.geCouriar(productId: productId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var productId =  Get.arguments["productId"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Payment"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Shipping Option",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: Obx(() =>
              purchaseController.getCoriarLoading.value ? ShimmerListView(cardHeight: 200.h) :
              purchaseController.couriar.isEmpty ? NoDataFoundCard() :
                 ListView.builder(
                  itemCount: purchaseController.couriar.length,
                  itemBuilder: (context, index) {
                    final courier = purchaseController.couriar[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: selectedIndex == index
                                ? Colors.orange
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Top Row (Logo + Radio)
                            Row(
                              children: [
                                Expanded(child: CustomText(
                                    textAlign: TextAlign.start,
                                    text: "${courier.name}", fontSize: 16.h, fontWeight: FontWeight.w700, color: Colors.green)),

                                SizedBox(width: 12.w),

                                Radio<int>(
                                  value: index,
                                  groupValue: selectedIndex,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedIndex = val!;
                                    });
                                  },
                                  activeColor: Colors.orange,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),

                            // SizedBox(height: 6.h),


                            CustomText(text: "Quote ID: ${courier.id}", color: Colors.black, fontWeight: FontWeight.w700),
                            CustomText(text: "Carrier: ${courier.carrier}", color: Colors.black),
                            CustomText(text: "Country: ${courier.countries?[0].name}", color: Colors.black),
                            CustomText(text: "Weight Limit: ${courier.minWeight}-${courier.maxWeight}KG", color: Colors.black),
                            CustomText(text: "Price: ${courier.countries?[0].price}", color: Colors.black),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),




            /// Bottom Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedIndex == -1
                    ? (){

                  ToastMessageHelper.showToastMessage(context, "Please select courier!", title: "info");
                }
                    : () {


                  Get.toNamed(AppRoutes.orderSummaryScreen, arguments: {
                    "productId" : "$productId",
                    "shippingId" : "${purchaseController.couriar[selectedIndex].id}"
                  });

                  // var selectedCourier = purchaseController.couriar[selectedIndex];

                  // var couriarInfo = {
                  //   "QuoteID": int.parse(purchaseController.quoteId.value),
                  //   "ServiceID": int.parse(selectedCourier.serviceId.toString()),
                  //   "order_id": int.parse(selectedCourier.serviceId.toString()),
                  //   "orderReference":"xcvxcv",
                  //   "serviceName": "${selectedCourier.serviceName}",
                  //   "carrierName": "${selectedCourier.carrierName}",
                  //   "chargeableWeight": int.parse(selectedCourier.chargeableWeight.toString()),
                  //   "transitTimeEstimate": "${selectedCourier.transitTimeEstimate}",
                  //   "sameDayCollectionCutOffTime": "${selectedCourier.sameDayCollectionCutOffTime}",
                  //   "isWarehouseService": selectedCourier.isWarehouseService,
                  //   "totalCostNetWithCollection": double.parse(selectedCourier.totalCost?.totalCostNetWithCollection.toString() ?? "") ,
                  //   "totalCostNetWithoutCollection": double.parse(selectedCourier.totalCost?.totalCostNetWithoutCollection.toString() ?? "") ,
                  //   "totalCostGrossWithCollection": double.parse(selectedCourier.totalCost?.totalCostGrossWithCollection.toString() ?? "") ,
                  //   "totalCostGrossWithoutCollection":double.parse(selectedCourier.totalCost?.totalCostGrossWithoutCollection.toString() ?? "") ,
                  // };

                  //
                  // purchaseController.shipment(data: {}, context: context, productId: productId);


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Select Courier",
                    style:
                    TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
            ),


            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }
}



