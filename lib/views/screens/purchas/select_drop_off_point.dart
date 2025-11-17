// drop_off_point_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/helper/toast_message_helper.dart';

import '../../../controller/purchase_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../widgets/custom_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DropOffPointScreen extends StatefulWidget {
  const DropOffPointScreen({super.key});

  @override
  State<DropOffPointScreen> createState() => _DropOffPointScreenState();
}

class _DropOffPointScreenState extends State<DropOffPointScreen> {
  List<ServicePoint> _servicePoints = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();
  var data = Get.arguments;

  @override
  void initState() {
    super.initState();
    _searchController.text = data["postalCode"];
    _fetchServicePoints(postalCode: data["postalCode"]);
  }



  Future<void> _fetchServicePoints({String? postalCode}) async {

    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });



      final points = await ApiService.getServicePoints(
        latitude: data["lat"],
        longitude: data["long"],
        country: '${data["country"]}',
        postalCode: postalCode
      );

      print("=====================Called Api");

      setState(() {
        _servicePoints = points;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _fetchServicePoints();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomText(
          text: "Select Drop-off Point",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Title
              CustomText(
                text: "Select a Drop-off Point",
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 8.h),

              // Subtitle
              CustomText(
                text: "Select a Drop-off Point Near You",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 24.h),

              // Search Container
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Icon(Icons.search, color: Colors.grey[500], size: 20.h),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Enter postal code or city",
                          hintStyle: TextStyle(
                            fontSize: 14.h,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 14.h,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          _fetchServicePoints(postalCode: _searchController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Loading and Error States
              if (_isLoading) ...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: CircularProgressIndicator(
                      color: AppColors.textColor767676,
                    ),
                  ),
                ),
              ] else if (_errorMessage.isNotEmpty) ...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Column(
                      children: [
                        CustomText(
                          text: "Error loading data",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: _fetchServicePoints,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: CustomText(
                            text: "Retry",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Available Drop-off Point Title
                CustomText(
                  text: "Available Drop-off Point (${_servicePoints.length})",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.left,
                  left: 0,
                ),

                SizedBox(height: 16.h),

                // Drop-off Point Cards
                Expanded(
                  child: ListView.builder(
                    itemCount: _servicePoints.length,
                    itemBuilder: (context, index) {
                      final point = _servicePoints[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _buildDropOffPointCard(point),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  PurchaseController purchaseController = Get.put(PurchaseController());
  Widget _buildDropOffPointCard(ServicePoint point) {

    return GestureDetector(
      onTap: () async{

        print("==================selected service ${purchaseController.servicePointId}");
        setState(() {
          purchaseController.servicePointId = point.id.toString();
        });



       await Future.delayed(Duration(seconds: 1));

        Get.back();

        ToastMessageHelper.showToastMessage(context, "Your drop-off point selected");

      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEAEAEA),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: point.id.toString() == purchaseController.servicePointId.toString() ? AppColors.primaryColor : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              CustomText(
                text: "Name : ${point.name}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 8.h),

              // Street
              CustomText(
                text: "Street : ${point.street}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 4.h),

              // House Number
              CustomText(
                text: "House Number : ${point.houseNumber}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 4.h),

              // Postal Code
              CustomText(
                text: "Postal Code : ${point.postalCode}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 4.h),

              // City
              CustomText(
                text: "City : ${point.city}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 8.h),

              // Opening Hours
              CustomText(
                text: "Opening Hours : ${point.getFormattedOpeningHours()}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                textAlign: TextAlign.left,
                left: 0,
              ),

              SizedBox(height: 8.h),

              // Carrier
              CustomText(
                text: "Carrier : ${point.carrier.toUpperCase()}",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor767676,
                textAlign: TextAlign.left,
                left: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}




// api_service.dart



class ApiService {
  static const String _baseUrl = 'https://servicepoints.sendcloud.sc/api/v2';
  static const String _username = 'fb447bde-14d9-4adf-9b23-cab2af16c26c';
  static const String _password = '0b66e82cf1d74f7585b3068bcc961079';

  // Basic Authentication header
  static String _getAuthHeader() {
    final credentials = '$_username:$_password';
    final bytes = utf8.encode(credentials);
    final base64Str = base64.encode(bytes);
    return 'Basic $base64Str';
  }

  static Future<List<ServicePoint>> getServicePoints({
    required String latitude,
    required String longitude,
    required String country,
     String? postalCode
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/service-points?latitude=$latitude&longitude=$longitude&country=$country&postal_code=${postalCode??""}'
        ),
        headers: {
          'Authorization': _getAuthHeader(),
          'Content-Type': 'application/json',
        },
      );

      print("============response: ${response.body} \n End point: /service-points?latitude=$latitude&longitude=$longitude&country=$country&postal_code=${postalCode??""}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServicePoint.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load service points: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load service points: $e');
    }
  }
}






// service_point_model.dart
class ServicePoint {
  final int id;
  final String code;
  final bool isActive;
  final String name;
  final String street;
  final String houseNumber;
  final String postalCode;
  final String city;
  final String carrier;
  final Map<String, dynamic> formattedOpeningTimes;

  ServicePoint({
    required this.id,
    required this.code,
    required this.isActive,
    required this.name,
    required this.street,
    required this.houseNumber,
    required this.postalCode,
    required this.city,
    required this.carrier,
    required this.formattedOpeningTimes,
  });

  factory ServicePoint.fromJson(Map<String, dynamic> json) {
    return ServicePoint(
      id: json['id'],
      code: json['code'],
      isActive: json['is_active'],
      name: json['name'],
      street: json['street'],
      houseNumber: json['house_number'],
      postalCode: json['postal_code'],
      city: json['city'],
      carrier: json['carrier'],
      formattedOpeningTimes: Map<String, dynamic>.from(json['formatted_opening_times']),
    );
  }

  // Helper method to format opening hours
  String getFormattedOpeningHours() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = DateTime.now().weekday - 1; // Monday is 0

    if (formattedOpeningTimes.containsKey(today.toString())) {
      final todayHours = formattedOpeningTimes[today.toString()];
      if (todayHours is List && todayHours.isNotEmpty) {
        return 'Today: ${todayHours[0]}';
      }
    }

    // If today not available, show first available day
    if (formattedOpeningTimes.isNotEmpty) {
      final firstDay = formattedOpeningTimes.keys.first;
      final firstHours = formattedOpeningTimes[firstDay];
      if (firstHours is List && firstHours.isNotEmpty) {
        final dayIndex = int.tryParse(firstDay) ?? 0;
        final dayName = days[dayIndex % 7];
        return '$dayName: ${firstHours[0]}';
      }
    }

    return 'Opening hours not available';
  }
}