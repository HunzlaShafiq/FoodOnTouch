import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/Models/OrderModel.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrdersProvider with ChangeNotifier {
  OrdersProvider() {
    getOrders();
  }

  List<OrderModel> _MyOrders = [];

  List<OrderModel> get myOrders => _MyOrders;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void loading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void clearOrderDataOnLogOut(){
    _MyOrders.clear();
  }

  void refreshOrderDataOnLogIn(){
    getOrders();

  }



  Future<void> addOrders(int totalPrice, String deliveryAddress,
      String paymentType, List items, BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    DateTime dateNow = DateTime.now();

    final currentTime = DateFormat('hh:mm a').format(dateNow);
    final currentDate = DateFormat(' MMMM d, y').format(dateNow);

    final orderRef = FirebaseFirestore.instance
        .collection('UserOrders')
        .doc(currentUser)
        .collection('Orders');

    orderRef.doc(id).set({
      'orderId': id,
      'totalPrice': totalPrice,
      'deliveryAddress': deliveryAddress,
      'paymentType': paymentType,
      'orderTime': currentTime,
      'orderDate': currentDate,
      'status': 'Processing',
      'rider':'',
      'riderLocation':'',
      'items': items
    }).then((value) {

      SuccessMessageToast().successToastMessage("OrderPlaced");
      showOrderPlaced(context);
      getOrders();
      Provider.of<CartProvider>(context,listen: false).deleteAllCartAfterOrderConfirm();

    }).onError((error, stackTrace) {
      ErrorToast().errorToastMessage(error.toString());
    });
  }

  Future<void> getOrders() async {
    loading(true);

    try {
      final ordersRef = await FirebaseFirestore.instance
          .collection('UserOrders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Orders')
          .get();

      List<OrderModel> allUsersOrders = [];

      for (var getOrderDetails in ordersRef.docs) {
        allUsersOrders.add(OrderModel(
            orderId: getOrderDetails['orderId'],
            totalPrice: getOrderDetails['totalPrice'],
            deliveryAddress: getOrderDetails['deliveryAddress'],
            paymentType: getOrderDetails['paymentType'],
            orderTime: getOrderDetails['orderTime'],
            orderDate: getOrderDetails['orderDate'],
            status: getOrderDetails['status'],
            items: getOrderDetails['items']));
      }

      _MyOrders = allUsersOrders;
      loading(false);
    } catch (e) {
      loading(false);
      ErrorToast().errorToastMessage(e.toString());
    }
  }

  void showOrderPlaced(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    "Order Placed Successfully",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Lottie.asset("assets/doneAnimation.json",
                      height: 200, width: 200)
                ],
              ),
            ),
            actions: [
              TextButton(

                  onPressed: () {
                    Navigator.pop(context);
                    Provider.of<BottomNavProvider>(context,listen: false).changeIndex(0);
                    Navigator.pushReplacementNamed(context, RoutesName.allScreens);
                  },
                  child: Text('Done', style: TextStyle(color: Colors.black),)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, RoutesName.myOrders);
                  },
                  child: Text('My Orders', style: TextStyle(color: Colors.black),))
            ],
          );
        });
  }
}
