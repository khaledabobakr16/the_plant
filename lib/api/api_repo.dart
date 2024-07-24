import 'package:dio/dio.dart';

class ApiRepo{
  Dio? _dio;
  String?url;
  Map<String,dynamic>?payload;
  ApiRepo({
    this.url,
    this.payload
  });
  void getData({
    Function()?beforeSend,
    Function(Map<String,dynamic> data)?onSuccess,
    Function(dynamic error)?onError,
  }) {
    _dio?.get(url!,queryParameters: payload).then((response) => {
      if(onSuccess!=null)
      {
        onSuccess(response.data)
      }
    // ignore: body_might_complete_normally_catch_error
    }).catchError((error){
      onError!(error);
    });
  }
}