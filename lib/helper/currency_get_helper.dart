

import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';

class CurrencyHelper {
  static getCurrencyPrice(String price)async{
    final currency = await PrefsHelper.getString(AppConstants.currency) ;
    return "$price $currency";
  }
}