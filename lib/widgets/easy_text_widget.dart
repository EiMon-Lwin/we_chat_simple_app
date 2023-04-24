import 'package:flutter/material.dart';

class EasyTextWidget extends StatelessWidget {
  const EasyTextWidget({Key? key,required this.text,this.textColor=Colors.white,this.fontSize=14,this.fontWeight=FontWeight.w300}) : super(key: key);

  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),

    );
  }
}
