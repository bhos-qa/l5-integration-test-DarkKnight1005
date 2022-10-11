import 'package:flutter/material.dart';
import 'package:tableapptest/providers/datetime_button_provider.dart';
import 'package:tableapptest/providers/home_provider.dart';
import 'package:tableapptest/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:tableapptest/utils/extensions/date_fomatter.dart';

class DateTimePickerButton extends StatelessWidget {

  final DateTime initialDateTime;
  final Function(DateTime? newDateTime)? onChange;

  DateTimePickerButton({ 
    Key? key,
    required this.initialDateTime,
    required this.onChange
  }) : super(key: key);

  // late DateTimeButtonProvider dateTimeButtonProvider;

  @override
  Widget build(BuildContext context) {

    // dateTimeButtonProvider = Provider.of<DateTimeButtonProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => DateTimeButtonProvider(initialDateTime),
      builder: (context, wg) =>  Consumer<DateTimeButtonProvider>(
      builder: (context, dateTimeButtonProvider, wg) => PrimaryButton(
        elementName: "DateButton",
        text: dateTimeButtonProvider.dateTime.formarDateSelect(), 
        onTap: () async {
          DateTime? pickedDateTime = await showDatePicker(
            context: context, 
            initialDate: initialDateTime,
            firstDate:  DateTime.now().subtract(Duration(days: (10 * 365))), 
            lastDate: initialDateTime
          );
          dateTimeButtonProvider.updateSelectedDateTime(pickedDateTime);
          this.onChange!(pickedDateTime);
        }
      ),
    )
  );
  }
}