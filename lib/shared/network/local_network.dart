import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork{
  static late SharedPreferences sharedPrefe;
  static Future caheIntilization()async{
    sharedPrefe = await SharedPreferences.getInstance();
  }
  static Future<bool> insertToCache({required String key,required String value})async{
  return  await sharedPrefe.setString(key, value);
  }
 static String getCache ({required String key}){
    return  sharedPrefe.getString(key) ?? '';
  }
static  Future<bool> deleteCaheItem({required String key}) async {
   return await sharedPrefe.remove(key);
  }

  static Future<bool> clearCache()async{
    return await sharedPrefe.clear();
  }
}