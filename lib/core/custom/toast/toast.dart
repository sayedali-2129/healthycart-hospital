import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

void sucessToast({required String text}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: BColors.buttonLightColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void errorToast({required String text}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: BColors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
