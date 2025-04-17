
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/FlushMessage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class  InternetConnectionCheckerProvider with ChangeNotifier{


  bool _isConnection = false;
  bool get isConnection => _isConnection;

  Future<bool> checkInternetConnection(BuildContext context) async{
    _isConnection = await InternetConnectionChecker().hasConnection;


    if(_isConnection ==false){

      // FlushMessage().flushErrorMessage("No internet Connection", context);
      Future.delayed(Duration(milliseconds:150),(){
        ErrorToast().errorToastMessage("No Internet");
      });
      return false;
    }

    else{
      return true;
    }

    notifyListeners();

  }



}