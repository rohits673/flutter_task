import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../failures/failures.dart';

enum HTTP { GET, POST, PUT, DELETE }

class Api {
  final Dio _dio = Dio();

  Future<Either<Failure, Response>> call(
    HTTP http,
    String url, {
    dynamic body,
  }) async {
    return _callApi(
      http,
      url,
      body: body,
    );
  }

  Future<Either<Failure, Response>> _callApi(
    HTTP http,
    String url, {
    dynamic body,
  }) async {
    try {
      Response response;
      switch (http) {
        case HTTP.GET:
          response = await _dio.get(
            url,
            options: Options(headers: await _getHeaders()),
          );
          break;
        case HTTP.POST:
          response = await _dio.post(
            url,
            data: body,
            options: Options(headers: await _getHeaders()),
          );
          break;
        case HTTP.PUT:
          response = await _dio.put(
            url,
            data: body,
            options: Options(headers: await _getHeaders()),
          );
          break;
        case HTTP.DELETE:
          response = await _dio.delete(
            url,
            data: body,
            options: Options(headers: await _getHeaders()),
          );
          break;
      }

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  Failure _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      getx.Get.snackbar('Connection Timeout', 'Please try again');
      return Failure(message: 'Connection Timeout', statusCode: null);
    } else {
      log(e.response.toString());
      try {
        if (e.response?.data["messages"]?.isNotEmpty ?? false) {
          e.response?.data["message"] = e.response?.data["messages"];
        }
        if (e.response?.data["errors"]?.isNotEmpty ?? false) {
          e.response?.data["message"] = e.response?.data["errors"];
        }
        return Failure(
          message: e.response?.data['message'][0] ?? e.message,
          statusCode: e.response?.statusCode,
        );
      } catch (_) {
        return Failure(
            message: e.response?.data?['message'] ?? e.message,
            statusCode: e.response?.statusCode);
      }
    }
  }
}
