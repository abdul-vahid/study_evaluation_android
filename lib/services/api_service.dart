import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:study_evaluation/utils/app_utils.dart';
import '../core/apis/app_exception.dart';

class APIService {
  Future getResponse(String url, String token) async {
    //AppUtils.printDebug("Token ----> $token");
    AppUtils.printDebug("API Serivce URL = ${url.substring(6)}");
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    //AppUtils.printDebug("responseData --> $responseJson");
    return responseJson;
  }

  Future postResponse(String url, var body, String token) async {
    AppUtils.printDebug("API Serivce URL = ${url.substring(6)}");
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future deleteResponse(String url, String token) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future getMultipartResponse(String url, Map<String, String> data) async {
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(data);
      http.StreamedResponse response = await request.send();

      var jsonResponse = await response.stream.bytesToString();
      responseJson = returnMultipartResponse(response, jsonResponse);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var jsonResponse = jsonDecode(response.body);
        //print(jsonResponse["records"]);
        return jsonResponse;
      case 201:
        var jsonResponse = jsonDecode(response.body);
        //print(jsonResponse["records"]);
        return jsonResponse;
      //return responseJson;
      case 204:
        var jsonResponse = jsonDecode(response.toString());
        //print('Delete jsonResponse ${jsonResponse}');
        return jsonResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        AppUtils.printDebug("Un Authorise");
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }

  @visibleForTesting
  dynamic returnMultipartResponse(
      http.StreamedResponse response, String jsonResponse) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(jsonResponse);
        return responseJson;
      case 400:
        throw BadRequestException(jsonResponse);
      case 401:
      case 403:
        throw UnauthorisedException(jsonResponse);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}
