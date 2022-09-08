import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
    {required BuildContext context,
    required String msg,
    Color color = const Color.fromRGBO(255, 255, 141, 1)}) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.black87);
}
