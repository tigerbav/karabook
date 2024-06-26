import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  
  static final _pickColorToast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.arrow_drop_down_circle_outlined),
        SizedBox(
          width: 12.0,
        ),
        Expanded(child: Text('Please, select a color from the panel below', style: TextStyle(fontSize: 12),)),
      ],
    ),
  );

  static final _completeToast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text('Congratulations! Mission completed :)'),
      ],
    ),
  );

  static FToast showCompleteToast(BuildContext context, int seconds) {
    return FToast()..init(context)..showToast(
      child: _completeToast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: seconds),
    );
  }

  static FToast showPickColorToast(BuildContext context, int seconds) {
    return FToast()..init(context)..showToast(
      child: _pickColorToast,
      gravity: ToastGravity.TOP,
      toastDuration:  Duration(seconds: seconds),
    );
  }

  
}