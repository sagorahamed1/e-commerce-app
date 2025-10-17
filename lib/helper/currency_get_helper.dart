

import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';

class CurrencyHelper {


  static String? _currency;


  static Future<void> init() async {
    _currency = await PrefsHelper.getString(AppConstants.currency);
  }


  static getCurrencyPrice(String price){
    if(price.isNotEmpty){
      double parsedPrice = double.tryParse(price) ?? 0.0;
      return "${parsedPrice.toStringAsFixed(2)} ${_currency?.toUpperCase()}";
    }else{
      return "0";
    }

  }
}

