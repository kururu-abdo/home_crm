import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_crm/data/models/toast_type.dart';

showToast(ToastType type , String message){

  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: 
        type ==ToastType.ERROR?
        
        Colors.red:  Colors.green  ,
        textColor: Colors.white,
        fontSize: 16.0
    );
}