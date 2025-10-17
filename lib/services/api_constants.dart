class ApiConstants{
  // static const String baseUrl = "http://192.168.40.142:5000/api/v1";
  // static const String imageBaseUrl = "http://192.168.40.142:5000";

  // static const String baseUrl = "https://petattix.merinasib.shop/api/v1";
  // static const String imageBaseUrl = "https://petattix.merinasib.shop";

  static const String baseUrl = "https://api.petattix.com/api/v1";
  static const String imageBaseUrl = "https://api.petattix.com";


  static const String signUpEndPoint = "/auth/signup";
  static const String loginEndPoint = "/auth/login";
  static const String signInEndPoint = "/auth/login";
  static const String emailVerify = "/auth/verify-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword = "/auth/reset-password";
  static const String profile = "/users/profile";
  static const String updatePassword = "/auth/update-password";


  static const String product = "/products";
  static const String walletHistory = "/transections?page=1&limit=1000";
  static const String mySales = "/orders/sales";
  static const String getCategory = "/categories";
  static const String favourites = "/favourites";
  static const String purches = "/orders/phurcases";
  static const String offerSend = "/offers/send";
  static  String changeStatus(String? id) => "/orders/${id}/completed";
  static const String notifications = "/notifications";
  static const String offerAccept = "/offers";
  static const String review = "/reviews";
  static const String reports = "/reports";
  static const String balance = "/wallets/balance";
  static const String walletBalanceAdd = "/wallets/recharge";
  static const String createDelivery = "/delivery";
  static const String productAnalyze = "/product/analyze";
  static  String favouite(String? page) => "/favourites?page=${page??""}&limit=10";
  static const String getChatUser = "/conversations?term=pet&limit=10";
  static String chatEndPoint(String? id) =>  "/messages/${id??""}?limit=100";
  static String createCollection(String? id) =>  "/delivery/${id}/collection";
  static String shipment(String? id) =>  "/delivery/${id}/shipment";
  static String couriar(String? id) =>  "/delivery/${id}/shipment/late";
}