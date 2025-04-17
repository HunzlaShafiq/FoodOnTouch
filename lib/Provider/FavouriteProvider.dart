
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Models/FavouriteItemsModel.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';

class FavouriteProvider with ChangeNotifier{

  FavouriteProvider(){
    getFavouriteItems();
  }
  


  bool _isFavourite =false;
  bool get isFavourite =>_isFavourite;

  bool _isLoading =false;
  bool get isLoading =>_isLoading;

  List<FavouriteItemsModel> _favouriteItemsList= [];
  List<FavouriteItemsModel> get favouriteItemsList =>_favouriteItemsList;

  void isFavourited(bool val){
    _isFavourite= val;
    myNotifierListener();
  }
  void myNotifierListener (){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update your state here
      notifyListeners();
    });

  }

  void clearFavouriteItemsOnUserLogOut(){
    _favouriteItemsList.clear();
    notifyListeners();
  }

  void refreshFavouriteItemsOnUserLogIn(){
    getFavouriteItems();
  }

  
  Future<void> addToFavourite(String id,String itemName,String itemID,String itemPrice,String itemImageUrl,String itemGreetingLine) async{

    final favouriteRef =FirebaseFirestore.instance
        .collection('UsersFavouriteItems')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('FavouriteItems');

    favouriteRef.doc(id).set({
      'id':id,
      'itemID':itemID,
      'itemName':itemName,
      'itemPrice':itemPrice,
      'itemImageUrl':itemImageUrl,
      'itemGreetingLine':itemGreetingLine

    })
        .then((value){
          getFavouriteItems();
          SuccessMessageToast().successToastMessage("Added go to favourite");
          notifyListeners();

    })
        .onError((error,stackTrace){
          ErrorToast().errorToastMessage(error.toString());

    });
    
    
    
  }


  Future<void> getFavouriteItems() async{
    _isLoading =true;
    notifyListeners();

    List<FavouriteItemsModel> items =[];

    final favouriteRef = await FirebaseFirestore.instance
        .collection('UsersFavouriteItems')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('FavouriteItems').get();

    for(var getFavourite in favouriteRef.docs){
      items.add(
          FavouriteItemsModel(
              id: getFavourite['id'],
              itemID: getFavourite['itemID'],
              itemName: getFavourite['itemName'],
              itemPrice: getFavourite['itemPrice'],
              itemImageUrl:getFavourite['itemImageUrl'],
              itemGreetingLine: getFavourite['itemGreetingLine'])
      );

    }

    _favouriteItemsList = items;
    _isLoading =false;
    notifyListeners();



  }

  Future<void> deleteFavouriteItem(String id) async{
    _isFavourite=false;
    notifyListeners();

    FirebaseFirestore.instance
        .collection('UsersFavouriteItems')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('FavouriteItems')
        .doc(id)
        .delete()
        .then((onValue){
          getFavouriteItems();
          notifyListeners();
          SuccessMessageToast().successToastMessage("Removed");


    });

  }



}

