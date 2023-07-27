import 'package:dio/dio.dart';
import 'package:nafcassete/src/helpers/dio_interceptor.dart';

final dio = Dio(
  BaseOptions(
    // baseUrl: 'https://yonefu2.xsrv.jp/showcase/json_data/',
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    receiveDataWhenStatusError: true,
    // connectTimeout: 100 * 1000, // 60 seconds
    // receiveTimeout: 100 * 1000),
  ),
)..interceptors.add(DioInterceptor());


