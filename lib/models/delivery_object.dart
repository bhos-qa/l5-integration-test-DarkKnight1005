import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:tableapptest/utils/extensions/date_fomatter.dart';

DeliveryObject deliveryObjectFromJson(String str) => DeliveryObject.fromJson(json.decode(str));

String deliveryObjectToJson(DeliveryObject data) => json.encode(data.toJson());

class DeliveryObject implements Comparable<DeliveryObject>{
    DeliveryObject({
        required this.storeId,
        required this.avgDeliveryTime,
        required this.worstDeliveryTime,
        required this.deliveryTimes,
    });

    final int storeId;
    int avgDeliveryTime;
    int worstDeliveryTime;
    List<int> deliveryTimes;

    factory DeliveryObject.fromJson(Map<String, dynamic> json) => DeliveryObject(
        storeId: json["storeNum"],
        avgDeliveryTime: json["avgDeliveryTime"],
        worstDeliveryTime: json["worstDeliveryTime"],
        deliveryTimes: List<int>.from(json["deliveryTimes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "avgDeliveryTime": DateTime(0, 0, 0 , 0 ,0, avgDeliveryTime).formatDeliveryTime(),
        "worstDeliveryTime": DateTime(0, 0, 0 , 0 ,0, worstDeliveryTime).formatDeliveryTime(),
        "deliveryTimes": List<int>.from(deliveryTimes.map((x) => x)),
    };

    @override
    int compareTo(DeliveryObject other) {
      if (this.storeId < other.storeId) {
        return -1;
      } else if (this.storeId > other.storeId) {
        return 1;
      } else {
        return 0;
      }
    }
}
