import 'package:dio/dio.dart';

class Api {
  late Dio dio;

  Api(String baseURL) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
