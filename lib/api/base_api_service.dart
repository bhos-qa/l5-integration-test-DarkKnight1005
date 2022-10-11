import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:tableapptest/consts/core_urls.dart';
import 'package:tableapptest/utils/helper/endpoint_builder.dart';

abstract class BaseAPIService {
  
  final Dio dio = new Dio();
  EndpointBuilder serviceBuilder = EndpointBuilder();
  // late String serviceUrl;

  BaseAPIService(String path) {
    // serviceUrl = CoreUrls.mainAPIurl + '/$path';
    serviceBuilder.addParam(path).saveCurrentParams();
     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  }
}
