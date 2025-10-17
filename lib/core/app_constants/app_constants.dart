class AppConstants {
static const String bearerToken = "bearerToken";
static const String currency = "currency";
static const String userId = "userId";
static const String email = "email";
static const String firstName = "firstName";
static const String lastName = "lastName";
static const String role = "role";
static const String image = "image";
static const String address = "address";
static const String phone = "phone";
static const String isLogged = "isLogged";


  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // static bool validatePassword(String value) {
  //   RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
  //   return regex.hasMatch(value);
  // }
static bool validatePassword(String value) {
  RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[A-Z]).{6,}$');
  return regex.hasMatch(value);
}
}