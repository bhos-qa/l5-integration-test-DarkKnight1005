import 'package:tableapptest/models/table_column.dart';

class TableConsts {

    TableConsts._();

    static const List<TableColumn> columns = [
      // TableColumn(id: "storeId", title: "Store"),
      TableColumn(id: "avgDeliveryTime", title: "Average delivery time"),
      TableColumn(id: "worstDeliveryTime", title: "Worst delivery time"),
  ];
}