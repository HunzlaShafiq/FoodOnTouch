import 'package:flutter/material.dart';
import 'package:fooddelivery/Screens/Address.dart';
import 'package:fooddelivery/Screens/AllScreen.dart';
import 'package:fooddelivery/Screens/ChangePassword.dart';
import 'package:fooddelivery/Screens/CheckOut.dart';
import 'package:fooddelivery/Screens/EditProfile.dart';
import 'package:fooddelivery/Screens/ForgetPassword.dart';
import 'package:fooddelivery/Screens/Home.dart';
import 'package:fooddelivery/Screens/LogIn.dart';
import 'package:fooddelivery/Screens/MyDetails.dart';
import 'package:fooddelivery/Screens/MyOrders.dart';
import 'package:fooddelivery/Screens/OrdersDetails.dart';
import 'package:fooddelivery/Screens/Payment.dart';
import 'package:fooddelivery/Screens/ProductPreview.dart';
import 'package:fooddelivery/Screens/SignUp.dart';
import 'package:fooddelivery/Screens/Splash.dart';

class RoutesName {
  static const splash ='splash';
  static const allScreens='allScreens';
  static const logIn ='logIn';
  static const signUp ='signUp';
  static const home ='Home';
  static const productPreview ='productPreview';
  static const editProfile ='editProfile';
  static const address ='address';
  static const payment ='payment';
  static const checkOut ='checkOut';
  static const myOrders ='myOrders';
  static const orderDetails ='orderDetails';
  static const myDetails ='myDetails';
  static const changePassword ='changePassword';
  static const forgetPassword ='forgetPassword';
}

class Routes{

 static Route<dynamic> generateRoute(RouteSettings settings){

   switch(settings.name){

     case RoutesName.allScreens:
       return MaterialPageRoute(builder: (context)=>AllScreens());

     case RoutesName.splash:
       return MaterialPageRoute(builder: (context)=>const Splash());

     case RoutesName.logIn:
       return MaterialPageRoute(builder: (context)=>const LogIn());

     case RoutesName.signUp:
       return MaterialPageRoute(builder: (context)=>const SignUp());

     case RoutesName.home:
       return MaterialPageRoute(builder: (context)=> const Home());

     case RoutesName.productPreview:
     return MaterialPageRoute(builder: (context)=> ProductPreview(data: settings.arguments));

     case RoutesName.address:
     return MaterialPageRoute(builder: (context)=> const Address());

     case RoutesName.payment:
       return MaterialPageRoute(builder: (context)=> const Payment());

     case RoutesName.editProfile:
       return MaterialPageRoute(builder: (context)=>EditProfile(data: settings.arguments,));

     case RoutesName.myDetails:
       return MaterialPageRoute(builder: (context)=> MyDetails(data: settings.arguments,));

     case RoutesName.checkOut:
     return MaterialPageRoute(builder: (context)=>const CheckOut());

     case RoutesName.myOrders:
       return MaterialPageRoute(builder: (context)=>const MyOrders());

     case RoutesName.forgetPassword:
       return MaterialPageRoute(builder: (context)=>const ForgetPassword());

     case RoutesName.orderDetails:
       return MaterialPageRoute(builder: (context)=>OrdersDetails(data: settings.arguments));

     case RoutesName.changePassword:
       return MaterialPageRoute(builder: (context)=>ChangePassword(data: settings.arguments,));

     default:
       return MaterialPageRoute(builder: (context)=>const Scaffold(
         body: Center(child: Text("no Route define")),
       ));
   }

 }
}