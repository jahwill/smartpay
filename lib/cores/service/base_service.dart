import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class BaseService {
  BaseService() {
    _init();
  }
  late final Dio _dio;
  var options = BaseOptions(
    baseUrl: "https://api.paystack.co/",
    connectTimeout: 50000,
    receiveTimeout: 50000,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    },
    contentType: 'application/json',
  );
  HttpClient client = HttpClient();

  _init() {
    _dio = Dio(options);

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  _dioRetry({int? retry}) {
    _dio.interceptors.add(RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: retry ?? 3,
        retryDelays: [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ]));
  }

  Future<Response> get(String path, {String? token, int? retry}) async {
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
    _dioRetry(retry: retry);
    Response res = await _dio.get(path);
    return res;
  }

  Future<Response> post(String path, Map<String, dynamic> obj,
      {String? token, String? pin, int? retry}) async {
    print("jjj");
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
      if (pin != null) {
        _dio.options.headers["pin"] = pin;
      }
      if (retry != null) {
        _dioRetry(retry: retry);
      }
    }

    Response res = await _dio.post(path, data: jsonEncode(obj));
    return res;
  }

  Future<Response> delete(String path, Map<String, dynamic> obj,
      {String? token}) async {
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }

    Response res = await _dio.delete(path, data: jsonEncode(obj));
    return res;
  }

  Future<Response> put(String path, Map<String, dynamic> obj,
      {String? token}) async {
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
    Response res = await _dio.put(path, data: jsonEncode(obj));
    return res;
  }

  Future<Response> patch() async {
    Response res = await _dio.patch('');
    return res;
  }

  Future<Response> postMultiPartFile(String path, FormData obj,
      {String? token}) async {
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }

    Response res = await _dio.post(path, data: obj);
    return res;
  }

  Future<Response> deleteMultiPartFile(String path, FormData obj,
      {String? token}) async {
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }

    Response res = await _dio.delete(path, data: obj);
    return res;
  }
}
