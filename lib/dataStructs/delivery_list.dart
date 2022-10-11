import 'package:tableapptest/models/delivery_data.dart';
import 'package:tableapptest/models/delivery_object.dart';
import 'package:collection/collection.dart';
import 'dart:math';

class DeliveryList{
  
  late List<DeliveryObject> _deliveryList;

  DeliveryList(){
    _deliveryList = []..length = 0;
  }

  void insert(DeliveryData deliveryData){
    bool isContains = _deliveryList.map((element) => element.storeId).toList().contains(deliveryData.storeId);

    if(!isContains){
      _deliveryList.add(new DeliveryObject(
        storeId: deliveryData.storeId,
        avgDeliveryTime: deliveryData.seconds,
        worstDeliveryTime: deliveryData.seconds,
        deliveryTimes: [deliveryData.seconds]
      ));

      //For Sorting
      _deliveryList.sort();

    }else{
      int elemIndex = _deliveryList.indexWhere((element) => element.storeId == deliveryData.storeId);
      _deliveryList[elemIndex].deliveryTimes.add(deliveryData.seconds);
      _deliveryList[elemIndex].avgDeliveryTime = _deliveryList[elemIndex].deliveryTimes.map((e) => e).average.toInt();
      _deliveryList[elemIndex].worstDeliveryTime = _deliveryList[elemIndex].deliveryTimes.reduce(max);
    }
  }

  void insertAll(List<DeliveryData> deliveryDataList){
    deliveryDataList.forEach((element) => this.insert(element));
  }

  void remove(DeliveryData deliveryData){
    _deliveryList.removeWhere((element) => element.storeId == deliveryData.storeId);
  }

  void clear(){
    _deliveryList.clear();
  }

  List<DeliveryObject> get deliveryList => _deliveryList;
}