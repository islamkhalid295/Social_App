import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async{
    return  sharedPreferences = await SharedPreferences.getInstance();
  }

}