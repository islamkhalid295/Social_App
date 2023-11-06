import 'package:dio/dio.dart';

//GET https://newsapi.org/v2/top-headlines?country=eg&apiKey=904c22d11a6c43fc9e5f24f8c1bb5cb8
// https://newsdata.io/api/1/news?country=eg&apikey=pub_28793fc9a3e454f2a8bd56e834c38948d309d
// https://student.valuxapps.com/api/
class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response>  getData(url, {quary,lang='ar',token}) async {
    dio?.options.headers = {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token??'',
    };
    return await dio!.get(url, queryParameters: quary);
  }

  static Future<Response> postData(url, data,{token}) async {
    dio?.options.headers = {
      'Authorization' : token,
      'Content-Type' : 'application/json',
    };
    return await dio!.post(url, data: data);
  }

  static Future<Response> putData(url, data,{token,lang='ar'}) async {
    dio?.options.headers = {
      'Authorization' : token,
      'lang' : lang??'ar',
      'Content-Type' : 'application/json',
    };
    return await dio!.put(url, data: data);
  }

}
