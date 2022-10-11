import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tableapptest/api/base_api_service.dart';
import 'package:tableapptest/models/delivery_data.dart';

class DeliveryService extends BaseAPIService {
  DeliveryService() : super('hometestDeliveries');

  Future<List<DeliveryData>> fetchData(String date) async {
    try {
      var _dioResponse = await dio.get(
        // serviceUrl,
        serviceBuilder.build(),
        queryParameters: {
          "date": date
        }
      );
      return deliveryDataFromJson(_dioResponse.data);
    } catch (e) {
      debugPrint(e.toString());
      var _error = e as DioError;
      if (_error.type == DioErrorType.response) {
        debugPrint(_error.response!.data.toString());
      }
      return [];
    }
  }
}
