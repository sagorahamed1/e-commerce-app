import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petattix/controller/wallet_controller.dart';
import 'package:petattix/helper/prefs_helper.dart';

import '../constants/constants.dart';


class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  PaymentController() {
    Stripe.publishableKey = AppConstants.publishAbleKey;
  }

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
      if (kDebugMode) {
        debugPrint("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error fetching payment intent: $e');
      }
      throw e;
    }
  }

  Future<void> makePayment(
      {String? subscriptionId, amount, required BuildContext context}) async {
    final currency = await PrefsHelper.getString("currency");
    try {
      paymentIntentData = await createPaymentIntent("$amount", "${currency.toUpperCase()}");

      if (paymentIntentData != null) {
        String clientSecret = paymentIntentData!['client_secret'];

        if (kDebugMode) {
          debugPrint("Client Secret: $clientSecret");
        }

        debugPrint("=========================currency : $currency");

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: const BillingDetails(name: 'Jo', email: 'support@petattix.com'),
              googlePay:  PaymentSheetGooglePay(merchantCountryCode: 'US', currencyCode: "USD", testEnv: false),
              applePay: PaymentSheetApplePay(
                merchantCountryCode: 'US',
              ),
              merchantDisplayName: 'Pet Attix',
              paymentIntentClientSecret: clientSecret,
              style: ThemeMode.dark),
        );

        displayPaymentSheet(
            subscriptionId: "$subscriptionId",
            context: context,
            amount: amount);
      }
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint('Exception: $e\nStack trace: $s');
      }
    }
  }




  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${AppConstants.secretKey}',
          // Use sk_test_... key here
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (kDebugMode) {
        debugPrint("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error creating payment intent: $e");
      }
      return null;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<void> displayPaymentSheet(
      {required String subscriptionId,
      amount,
      required BuildContext context}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      retrieveTxnId(
          paymentIntent: paymentIntentData!['id'],
          subscriptionId: '$subscriptionId',
          context: context,
          amount: amount);

      ///subscription id
      if (kDebugMode) {
        debugPrint('Payment intent: $paymentIntentData');
      }
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text("Paid successfully")));
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error displaying payment sheet: $e");
      }
    }
  }

  Future<void> retrieveTxnId(
      {required String paymentIntent,
      amount,
      required String subscriptionId,
      required BuildContext context}) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
        headers: {
          "Authorization": "Bearer ${AppConstants.secretKey}",
          // Use sk_test_... key here
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          debugPrint("==========================data ${data}");
          debugPrint(
              "Transaction Id: ${data['data'][0]['balance_transaction']}");
        }
        var transactionId = data['data'][0]['balance_transaction'];
        debugPrint("======================  $subscriptionId");
        final WalletController subscriptionController =
            Get.put(WalletController());

        subscriptionController.addBalanceToWallet(
            amount: "$amount",
            trxId: transactionId,
            context: context,
            paymentIntentId: paymentIntent);
        // subscriptionController.payment(subscriptionId: subscriptionId, transactionId: "$transactionId");
      } else {
        print("******************************************************************************************************");
      }
    } catch (e) {
      throw Exception("Error retrieving transaction ID: $e");
    }
  }
}
