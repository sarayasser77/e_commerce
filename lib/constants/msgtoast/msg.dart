import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

getFlutterToast(String message,Color color ){
  Toast.show('$message',
    backgroundColor: color,
    textStyle: const TextStyle(color: Colors.white,fontSize: 16),
    gravity: Toast.bottom,
    duration: 1,
  );
  if (ToastContext().context == null) {
    throw Exception('Context is null, please call ToastContext.init(context) first');
  }
}