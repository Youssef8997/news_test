import 'package:hamazh_auth/utls/constant/keys_constant.dart';

class EndPointConstant {
  static const String baseUrl = "https://api.nytimes.com/svc/topstories/v2";
  static const String apiKey = "NgGTUayqkspuPvoLSy0K7DnLAU3bVcNA";
  static const String homeUrl = "$baseUrl/${KeysConstant.homeKey}.json";
  static const String worldUrl = "$baseUrl/${KeysConstant.worldKey}.json";
  static const String usUrl = "$baseUrl/${KeysConstant.usKey}.json";
  static const String artsUrl = "$baseUrl/${KeysConstant.artsKey}.json";
  static const String healthUrl = "$baseUrl/${KeysConstant.healthKey}.json";
  static const String foodUrl = "$baseUrl/${KeysConstant.foodKey}.json";
}
