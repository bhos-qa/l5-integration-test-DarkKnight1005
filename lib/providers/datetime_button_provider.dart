
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:tableapptest/dataStructs/delivery_list.dart';
import 'package:tableapptest/models/delivery_data.dart';
import 'package:tableapptest/models/delivery_object.dart';

class DateTimeButtonProvider extends ChangeNotifier {
  
  late DateTime _dateTime;

  DateTimeButtonProvider(DateTime initialDateTime){
    _dateTime = initialDateTime;
  }

  void updateSelectedDateTime(DateTime? newDateTime){
    if(newDateTime != null){
      _dateTime = newDateTime;
      notifyListeners();
    }
  }

  DateTime get dateTime => _dateTime;
}
