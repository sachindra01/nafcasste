// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nafcassete/src/helpers/dio_client.dart';
import 'package:nafcassete/src/widgets/custom_toast.dart';

class ApiRepo{
  static apiPost(apiPath,params, [apiName]) async {
    try {
      var response = await dio.post(apiPath, data: params);
      if (response.statusCode == 200 && response.data['resultCode'] == 0) {
        if (kDebugMode) {
          debugPrint('ApiName => $apiName');
          debugPrint('ApiPath => $apiPath');
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException  catch (e) {
      if(e.response!=null){
        showToastMessage(e.toString());
        // log(e.response!.data['message'].toString());
        return e.response!.data;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static apiGet(apiPath,queryParameters, [apiName]) async {
    try {
      var response = await dio.get(apiPath, queryParameters: queryParameters==''?{}:queryParameters);
      if (response.statusCode == 200 && response.data['resultCode'] == 0) {
        if (kDebugMode) {
          debugPrint('ApiName => $apiName');
          debugPrint('ApiPath => $apiPath');
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException  catch (e) {
      // showToastMessage(e.toString());
      log(e.response!.data['message'].toString());
      return e.response!.data;
    } catch (e) {
      log(e.toString());
    }
  }
  
  static apiPut(apiPath,queryParameters) async {
    try {
      var response = await dio.put(apiPath, data: queryParameters);
      if (response.statusCode == 200 && response.data['resultCode'] == 0) {
        if (kDebugMode) {
          debugPrint('ApiPath => '+ apiPath);
          // debugPrint('QueryParameters => '+ queryParameters.toString());
          // debugPrint('Response => ' +response.toString());
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException  catch (e) {
      showToastMessage(e.toString());
      // log(e.response!.data['message'].toString());
      return e.response!.data;
    } catch (e) {
      log(e.toString());
    }
  }

  static apiDelete(apiPath,[apiName]) async {
    try {
      var response = await dio.delete(apiPath);
      if (response.statusCode == 200 && response.data['resultCode'] == 0) {
        if (kDebugMode) {
          debugPrint('ApiName => $apiName');
          debugPrint('ApiPath => $apiPath');
          // debugPrint('Response => ' +response.toString());
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException  catch (e) {
      showToastMessage(e.toString());
      // log(e.response!.data['message'].toString());
      return e.response!.data;
    } catch (e) {
      log(e.toString());
    }
  }

}