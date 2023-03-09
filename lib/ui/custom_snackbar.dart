import 'package:flutter/material.dart';
import 'package:maps_app/widgets/widgets.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    Duration duration = const Duration( seconds: 2),
    VoidCallback? onOk
  }): super(
    key: key,
    content: Text(message),
    action: SnackBarAction(label: btnLabel, onPressed: (){
      if (onOk != null){
        onOk();
      }
    }),
    duration: duration
  );
  
}