import 'package:meta/meta.dart';
import 'dart:convert';

List<DeliveryData> deliveryDataFromJson(Object obj) => List<DeliveryData>.from(json.decode(json.encode(obj)).map((x) => DeliveryData.fromJson(x)));

String devliveryDataToJson(List<DeliveryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryData {
    DeliveryData({
        required this.orderId,
        required this.storeId,
        required this.date,
        required this.seconds,
    });

    final int orderId;
    final int storeId;
    final DateTime date;
    final int seconds;

    factory DeliveryData.fromJson(Map<String, dynamic> json) => DeliveryData(
        orderId: json["orderId"],
        storeId: json["storeId"],
        date: DateTime.parse(json["date"]),
        seconds: json["seconds"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "storeId": storeId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "seconds": seconds,
    };

}
