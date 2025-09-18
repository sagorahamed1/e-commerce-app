import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
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
              "Select a courier service",
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
                                CustomText(text: "${courier.serviceName}", fontSize: 16.h, fontWeight: FontWeight.w700, color: Colors.green),

                                const Spacer(),
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

                            /// Service Type
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Service Type",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey.shade600)),
                                DropdownButton<String>(
                                  value: "Air",
                                  underline: const SizedBox(),
                                  items: ["Air", "Sea", "Land"]
                                      .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                                      .toList(),
                                  onChanged: (_) {},
                                ),
                              ],
                            ),

                            // SizedBox(height: 6.h),

                            Obx(() => CustomText(text: "Quote ID: ${purchaseController.quoteId.value}", color: Colors.black)),

                            Text("Chargeable Weight: ${courier.chargeableWeight} Kg"),
                            Text(
                                "Transit time estimation (days): ${courier.transitTimeEstimate}"),

                            SizedBox(height: 12.h),
                            Text("Service Cost Breaks down:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13.sp)),

                            SizedBox(height: 6.h),

                            ListView.builder(
                                itemCount: courier.servicePriceBreakdown?.length,
                                shrinkWrap: true,
                                physics:  NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var x = courier.servicePriceBreakdown?[index];
                                  return  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       Text("${x?.description}"),
                                      Text("\$${x?.cost}",
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  );
                                }),


                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text("Collection"),
                            //     Text("\$${courier.collection}",
                            //         style: TextStyle(color: Colors.red)),
                            //   ],
                            // ),
                             Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total Cost",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text("\$${courier.totalCost?.totalCostNetWithCollection}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
                              ],
                            ),
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

                  ToastMessageHelper.showToastMessage(context, "Please select couriar!", title: "info");
                }
                    : () {

                  var selectedCourier = purchaseController.couriar[selectedIndex];

                  var couriarInfo = {
                    "QuoteID": int.parse(purchaseController.quoteId.value),
                    "ServiceID": int.parse(selectedCourier.serviceId.toString()),
                    "order_id": int.parse(selectedCourier.serviceId.toString()),
                    "orderReference":"xcvxcv",
                    "serviceName": "${selectedCourier.serviceName}",
                    "carrierName": "${selectedCourier.carrierName}",
                    "chargeableWeight": int.parse(selectedCourier.chargeableWeight.toString()),
                    "transitTimeEstimate": "${selectedCourier.transitTimeEstimate}",
                    "sameDayCollectionCutOffTime": "${selectedCourier.sameDayCollectionCutOffTime}",
                    "isWarehouseService": selectedCourier.isWarehouseService,
                    "totalCostNetWithCollection": double.parse(selectedCourier.totalCost?.totalCostNetWithCollection.toString() ?? "") ,
                    "totalCostNetWithoutCollection": double.parse(selectedCourier.totalCost?.totalCostNetWithoutCollection.toString() ?? "") ,
                    "totalCostGrossWithCollection": double.parse(selectedCourier.totalCost?.totalCostGrossWithCollection.toString() ?? "") ,
                    "totalCostGrossWithoutCollection":double.parse(selectedCourier.totalCost?.totalCostGrossWithoutCollection.toString() ?? "") ,
                  };

                  
                  purchaseController.shipment(data: couriarInfo, context: context, productId: productId);


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Make Payment",
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



