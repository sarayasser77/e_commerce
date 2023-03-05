import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

getFlutterToast(String message,Color color ){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16,
  );
}