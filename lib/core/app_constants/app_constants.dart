class AppConstants {
static const String bearerToken = "bearerToken";
static const String userId = "userId";
static const String email = "email";
static const String name = "name";
static const String role = "role";


  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // static bool validatePassword(String value) {
  //   RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
  //   return regex.hasMatch(value);
  // }
static bool validatePassword(String value) {
  // অন্তত 1টা সংখ্যা, অন্তত 1টা Capital letter, এবং কমপক্ষে 6 অক্ষর
  RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[A-Z]).{6,}$');
  return regex.hasMatch(value);
}
}