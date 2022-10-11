
import 'package:flutter/material.dart';
import 'package:tableapptest/dataStructs/delivery_list.dart';
import 'package:tableapptest/models/delivery_data.dart';
import 'package:tableapptest/models/delivery_object.dart';

class DeliveryProvider extends ChangeNotifier {
  
  List<DeliveryData>? _deliveryData;

  DeliveryList _sortedDeliveryData = DeliveryList();

  void updateDeliveryData(List<DeliveryData>? newDeliveryData) {
    _deliveryData = newDeliveryData;
    _sortDeliveryData();
    notifyListeners();
  }

  void addNewDeliveryData(DeliveryData deliveryData){
    _sortedDeliveryData.insert(deliveryData);
    notifyListeners();
  }

  void removeNewDeliveryData(DeliveryData deliveryData){
    _sortedDeliveryData.remove(deliveryData);
    notifyListeners();
  }

  void _sortDeliveryData({List<DeliveryData>? deliveryDataList, bool needNotify = false}){
    _sortedDeliveryData.clear();
    _sortedDeliveryData.insertAll(deliveryDataList ?? this._deliveryData!);
    if(needNotify) notifyListeners();
  }

  List<DeliveryData>? get deliveryData => _deliveryData;

  List<DeliveryObject>? get sortedDeliveryData => _sortedDeliveryData.deliveryList;
}
