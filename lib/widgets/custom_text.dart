import 'package:flutter/material.dart';
import 'package:pockettasks/state_mgt/tasks_provider.dart';
import 'package:provider/provider.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color = Colors.black,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    // final taskprovider = Provider.of<TasksProvider>(context);
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        // color: taskprovider.isDarkmode ? Colors.white : Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
 }
