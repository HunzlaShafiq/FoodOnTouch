
import 'package:flutter/material.dart';
import 'package:fooddelivery/Screens/Cart.dart';
import 'package:fooddelivery/Screens/Favourite.dart';
import 'package:fooddelivery/Screens/Home.dart';
import 'package:fooddelivery/Screens/Profile.dart';

class BottomNavProvider with ChangeNotifier
{

  int _index =0;
  int get index =>_index;

  void changeIndex(int val){

    _index =val;
    notifyListeners();
  }

  static const List<Widget> _pages = <Widget>[
    Home(),
    Favorite(),
    Cart(),
    Profile()
  ];

  List<Widget> get pages => _pages;

}