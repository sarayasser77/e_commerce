import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio=Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
          headers: {
              'Content-Type':'application/json '
          }
        )
    );
  }
  static Future<Future<Response>?> postData({
  required String url,
    required Map<String,dynamic>data,
})async{
    return dio?.post(
      url,
      data: data
    );
  }
}