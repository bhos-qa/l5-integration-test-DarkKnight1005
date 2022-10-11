
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:tableapptest/dataStructs/delivery_list.dart';
import 'package:tableapptest/models/delivery_data.dart';
import 'package:tableapptest/models/delivery_object.dart';

class HomeProvider extends ChangeNotifier {
  
  DateTime _dateTime = DateTime.now().subtract(Duration(days: 1));
  List<ExpandableTableRow> _rows = [];

  void updateSelectedDateTime(DateTime? newDateTime){
    if(newDateTime != null){
      _dateTime = newDateTime;
      notifyListeners();
    }
  }

  set rows(List<ExpandableTableRow> rows){
    this._rows = rows;
    notifyListeners();
  }

  void clearRows(){
    this._rows.clear();
    notifyListeners();
  }

  DateTime get dateTime => _dateTime;
  List<ExpandableTableRow> get rows => _rows;
}
