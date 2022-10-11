import 'package:intl/intl.dart';

DateFormat dateSelectFormat = DateFormat("yyyy-MM-dd");
DateFormat deliveryFormatMinutes = DateFormat("m");
DateFormat deliveryFormatSeconds = DateFormat("ss");

extension DateFormatter on DateTime {
  String formarDateSelect() {
    return dateSelectFormat.format(this);
  }

  String formatDeliveryTime() {
    String minutesWord = "minute" + (this.minute > 1 ? "s" : "");
    String secondsWord = "second" + (this.second > 1 ? "s" : "");
    return "${deliveryFormatMinutes.format(this)} $minutesWord ${deliveryFormatSeconds.format(this)} $secondsWord";
  }
}
