import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      debugPrint(error.toString());
      switch (error.type) {
        case DioErrorType.other:
          if (error.error is SocketException) {
            return "Connection to server failed due to internet connection.";
          } else if (error.response?.statusCode == -9) {
            return "No Active Internet Connection";
          } else {
            return "Something went wrong. Please try after sometime.";
          }
          break;
        case DioErrorType.cancel:
          return "Request to server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          return "Connection timeout with server";

        case DioErrorType.receiveTimeout:
          return "Request can't be handled for now. Please try after sometime.";

        case DioErrorType.response:
          debugPrint("Response:");
          debugPrint(error.toString());
          if (error.response!.statusCode == 12039 || error.response!.statusCode == 12040) {
            return "Connection to server failed due to internet connection.";
          } else if (401 == error.response!.statusCode) {
            return "Please login again.";
          } else if (401 < error.response!.statusCode! && error.response!.statusCode! <= 417) {
            return "Something when wrong. Please try again.";
          } else if (500 <= error.response!.statusCode! && error.response!.statusCode! <= 505) {
            return
                "Request can't be handled for now. Please try after sometime.";
          } else {
            return "Something went wrong. Please try after sometime.";
          }

        case DioErrorType.sendTimeout:
          return "Request can't be handled for now. Please try after sometime.";
      }
    } else {
      return "Something went wrong. Please try after sometime.";
    }
    return errorDescription;
  }
}
