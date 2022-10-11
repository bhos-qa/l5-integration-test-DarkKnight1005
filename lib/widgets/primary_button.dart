import 'package:flutter/material.dart';
import 'package:tableapptest/consts/color_consts.dart';

class PrimaryButton extends StatelessWidget {

  final String elementName;
  final String text;
  final void Function()? onTap;

  const PrimaryButton({ 
    Key? key ,
    required this.text,
    required this.onTap,
    required this.elementName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(elementName),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ColorConsts.borderColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ),
      ),
    );
  }
} 