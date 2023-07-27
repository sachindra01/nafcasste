import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';

class DioInterceptor extends Interceptor {
  
  @override
  // ignore: unnecessary_overrides
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var token = read("tokenId");
    options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR PATH: ${err.requestOptions.path} ');
    if(err.response?.statusCode == 503) { 
      // if(err.response?.data['message'] == 'Unauthenticated.' || err.response?.data['message'] == 'Unauthenticated User') {
      //   Get.off(() => const Login());
      //   Get.delete<AuthController>();
        // remove('apiToken');
      // }
      showToastMessage('Server down!!!.');
    }
    return super.onError(err, handler);
  }
}