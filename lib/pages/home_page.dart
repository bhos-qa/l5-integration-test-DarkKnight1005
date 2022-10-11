import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:tableapptest/api/delivery_service.dart';
import 'package:tableapptest/consts/color_consts.dart';
import 'package:tableapptest/consts/spacing_consts.dart';
import 'package:tableapptest/consts/table_consts.dart';
import 'package:tableapptest/models/delivery_data.dart';
import 'package:tableapptest/providers/delivery_provider.dart';
import 'package:tableapptest/providers/home_provider.dart';
import 'package:tableapptest/widgets/datetime_picker_button.dart';
import 'package:tableapptest/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:tableapptest/utils/extensions/date_fomatter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage>{

  static int row_count = 1;

  static DeliveryService deliveryService = DeliveryService();

  static DeliveryProvider? deliveryProvider;
  late HomeProvider homeProvider;
  
  @override
  void afterFirstLayout(BuildContext context) {
    _getDeliveryData();
  }

  Future<void> _getDeliveryData() async{

    List<DeliveryData> _data = await deliveryService.fetchData(homeProvider.dateTime.formarDateSelect());

    if(deliveryProvider != null){ 
      deliveryProvider!.updateDeliveryData(_data); 
      row_count = deliveryProvider!.sortedDeliveryData!.length;
    }else{
      row_count = 0;
    }
    
    homeProvider.rows = List.generate(
      row_count, 
      (rowIndex) => ExpandableTableRow(
        height: 80,
        firstCell: Container(
            color: ColorConsts.accentColor,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
                  "${deliveryProvider?.sortedDeliveryData?[rowIndex].storeId}",
              // style: textStyle,
            )
          )
        ),
        children: <Widget>[
          for (var item in TableConsts.columns) ...[
            Container(
                color: ColorConsts.accentColor,
                margin: EdgeInsets.all(1),
                child: Center(
                    child: Text(
                      "${deliveryProvider?.sortedDeliveryData?[rowIndex].toJson()[item.id]}",
                )
              )
            )
          ]
        ]
      )
    );
  }

  ExpandableTableHeader header = ExpandableTableHeader(
    firstCell: Container(
        color: ColorConsts.accentColor,
        margin: EdgeInsets.all(1),
        child: Center(
            child: Text(
          'Store',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          // style: textStyle,
        )
      )
    ),
    children: List.generate(
        TableConsts.columns.length,
        (index) => Container(
            color: ColorConsts.accentColor,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              TableConsts.columns[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          )
        )
      )
    );

  Widget _buildDateTimePicker(){
    return DateTimePickerButton(
      initialDateTime: homeProvider.dateTime,
      onChange: (pickedDateTime){
         homeProvider.updateSelectedDateTime(pickedDateTime);
      }
    );
  }

  Widget _buildTable(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        // width: MediaQuery.of(context).size.width * 0.8,
        child: homeProvider.rows.isNotEmpty 
        ? ExpandableTable(
          cellHeight: 80,
          cellWidth: 200,
          firstColumnWidth: 100,
          headerHeight: 60,
          rows: homeProvider.rows,
          header: header,
          scrollShadowColor: Colors.grey[100]!,
        )
        : Center(
            child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Colors.white,
            )
          ),
        )
      ),
    );
  } 
  
  Widget _buildPrimaryButton(){
    return PrimaryButton(
      elementName: "RefreshButton",
      text: "Refresh",
      onTap: homeProvider.rows.isNotEmpty 
      ? (){
          homeProvider.clearRows();
          _getDeliveryData();
        }
      : null
    );
  }

  Widget _buildHeaders(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingConsts.kHorizontalPadding, 
        16, 
        SpacingConsts.kHorizontalPadding,
        0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Delivery Statistics",
            style: TextStyle(
              color: ColorConsts.titleTextColor,
              fontSize: 22,
            ),
          ),
          Container(
            width: 100,
            height: 30,
            child: Placeholder(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    deliveryProvider = Provider.of<DeliveryProvider>(context);
    homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: ColorConsts.primaryColor,
          child: SafeArea(
            child: Column(
              children: [
                _buildHeaders(),
                _buildTable(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     _buildDateTimePicker(),
                     _buildPrimaryButton(),
                  ],
                )            
              ],
            ),
          ),
        ),
      ),
    );
  }
}