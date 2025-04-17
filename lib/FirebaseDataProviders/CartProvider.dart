import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Models/CartItemModel.dart';

import '../Utils/Components/ErrorToast.dart';

class CartProvider with ChangeNotifier {

  CartProvider() {
    getCartItems();

  }

  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _itemAddedCart = false;
  bool get itemAddedCart => _itemAddedCart;

  int _itemQuantity = 1;
  int get itemQuantityValue => _itemQuantity;

  List<String> _itemIdList = [];
  List get itemIdList => _itemIdList;

  List<CartItemModel> _cartItemsList = [];
  List<CartItemModel> get cartItemsList => _cartItemsList;

  int _totalPrice=0;
  int get totalPrice =>_totalPrice;

  void itemSelectedToCart(bool val) {
    _itemAddedCart = val;
    myNotifierListener();
  }

  clearCartItemsOnUserLogOut(){
    _cartItemsList.clear();
    _itemIdList.clear();
    notifyListeners();
  }

  refreshCategoriesOnUserLogIn(){
    getCartItems();
  }





  void myNotifierListener (){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update your state here
      notifyListeners();
    });

  }



  Future<void> getCartItems() async {

    _isLoading =true;
    notifyListeners();

    try{

      List<String> id = [];
      List<CartItemModel> cartItems = [];

      final QuerySnapshot cartItemsRef = await FirebaseFirestore.instance
          .collection('CartProducts')
          .doc(currentUser)
          .collection('UserCartItems')
          .get();

      for (var snapshot in cartItemsRef.docs) {

        id.add(snapshot['itemId']);
        cartItems.add(CartItemModel(
            id: snapshot['id'],
            itemId:snapshot ['itemId'],
            itemImageUrl:snapshot ['itemImageUrl'],
            itemName:snapshot ['itemName'],
            itemGreetingLine:snapshot ['itemGreetingLine'],
            itemPrice:snapshot ['itemPrice'],
            itemQuantity:snapshot ['itemQuantity'],
            itemSize: snapshot ['itemSize']
        ));
      }

      _cartItemsList= cartItems;
      _itemIdList = id;

    }
    catch(e){
      ErrorToast().errorToastMessage(e.toString());
    }
    finally{
      totalPriceInCart();
      _isLoading=false;
      notifyListeners();
    }


  }



  Future<void> updateQuantity(String id,int updatedQuantity) async{


    FirebaseFirestore.instance
        .collection('CartProducts')
        .doc(currentUser)
        .collection('UserCartItems').doc(id).update({
      'itemQuantity':updatedQuantity
    })

        .then((onValue){
          for(var quantityCheck in _cartItemsList){
            if(quantityCheck.id==id){
              quantityCheck.itemQuantity =updatedQuantity;
              totalPriceInCart();
              notifyListeners();
            }
          }




    })
        .onError((error,stackTrace){

      ErrorToast().errorToastMessage(error.toString());

    });

  }

  Future<void> updateItemSize(String id,String updatedItemSize) async{


    FirebaseFirestore.instance
        .collection('CartProducts')
        .doc(currentUser)
        .collection('UserCartItems').doc(id).update({
        'itemSize':updatedItemSize
    })

        .then((onValue){
      for(var quantityCheck in _cartItemsList){
        if(quantityCheck.id==id){
          quantityCheck.itemSize =updatedItemSize;
          totalPriceInCart();
          notifyListeners();
        }
      }




    })
        .onError((error,stackTrace){

      ErrorToast().errorToastMessage(error.toString());

    });

  }


  Future<void> deleteItemFromCart(String id) async{

    notifyListeners();
    FirebaseFirestore.instance
        .collection('CartProducts')
        .doc(currentUser)
        .collection('UserCartItems').doc(id).delete()

        .then((onValue){
      ErrorToast().errorToastMessage("Remove");
      itemSelectedToCart(false);
      getCartItems();
      totalPriceInCart();
      notifyListeners();

    })
        .onError((error,stackTrace){

      ErrorToast().errorToastMessage(error.toString());

    });

  }


  Future<void> deleteAllCartAfterOrderConfirm() async{

    final cartRef =await FirebaseFirestore.instance
        .collection('CartProducts')
        .doc(currentUser)
        .collection('UserCartItems').get();

    for(var x in cartRef.docs){
      x.reference.delete();
    }

    FirebaseFirestore.instance
        .collection('CartProducts')
        .doc(currentUser).delete().then((value){
          _cartItemsList.clear();
          _itemIdList.clear();
          notifyListeners();
    });



  }

  void totalPriceInCart(){
    int totalSum=0;

    for(var addAllPrice in cartItemsList)
      {
        totalSum += (addAllPrice.itemQuantity * int.parse(addAllPrice.itemPrice));

      }
    _totalPrice=totalSum;
    notifyListeners();

  }





}
