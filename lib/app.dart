import 'package:flutter/material.dart';
import 'package:tableapptest/consts/color_consts.dart';
import 'package:tableapptest/pages/home_page.dart';
import 'package:tableapptest/providers/delivery_provider.dart';
import 'package:tableapptest/providers/home_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: ColorConsts.primaryColor),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      home: 
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DeliveryProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}
