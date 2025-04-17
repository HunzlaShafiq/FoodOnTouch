
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';


class FlushMessage{


  void flushErrorMessage(String message, BuildContext context) {
   showFlushbar(
       context: context,
       flushbar:  Flushbar(
         padding: EdgeInsets.all(10),
       message: message,
       messageColor: Colors.black,
       flushbarStyle: FlushbarStyle.FLOATING,
       duration: Duration(milliseconds: 150),
       backgroundColor: Colors.white,
       barBlur: 2,
       flushbarPosition: FlushbarPosition.TOP,
       icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4,color: Colors.red,),
       borderRadius: BorderRadius.circular(10),
   )..show(context)
   );

  }

  void flushSuccessMessage(String message){

  }

}