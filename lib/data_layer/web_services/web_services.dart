import 'package:blocomarahmed/constant/helper.dart';
import 'package:dio/dio.dart';

class WebServices{

  late Dio dio;

  WebServices(){
    BaseOptions options=BaseOptions(
      baseUrl:baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    );
    dio=Dio(
      options
    );

  }

  Future<Map<String,dynamic>> getAllCharacter()async{
    
    
    try{
      Response response =await dio.get(path);
      print(response.data);
      return response.data;

    }
    catch(error){
      print(error.toString());
      return {} ;

    }
    
    

  }


}
// dio.interceptors.add(LogInterceptor(
// responseBody: true,
// error: true,
// requestHeader: true,
// request: true,
// requestBody: true
// ));