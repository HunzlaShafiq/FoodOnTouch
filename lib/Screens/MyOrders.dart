import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fooddelivery/FirebaseDataProviders/OrdersProvider.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/OrdersList.dart';
import 'package:fooddelivery/Utils/LoadingSkletons/OrdersLoadingSkleton.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Provider.of<BottomNavProvider>(context,listen: false).changeIndex(3);
              Navigator.pushReplacementNamed(context, RoutesName.allScreens);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Consumer<OrdersProvider>(
                builder: (context, orderProviderValues, child) {

      if (orderProviderValues.isLoading) {
        return OrdersLoadingSkleton()
        ;
      }

      else if (orderProviderValues.myOrders.isEmpty) {
        return Center(
          child: Text("No Orders Yet"),
        );
      }

      else {
        return SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          header: WaterDropHeader(),
          onRefresh: (){
            orderProviderValues.refreshOrderDataOnLogIn();
             setState(() {
               _refreshController.refreshCompleted();
             });

          },

          child: ListView.builder(
              itemCount: orderProviderValues.myOrders.length,
              itemBuilder: (context, index) {
                final orderDetails =
                    orderProviderValues.myOrders[index];

                final orderId = orderDetails.orderId;
                final orderStatus = orderDetails.status;
                final orderDate = orderDetails.orderDate;
                final orderTime = orderDetails.orderTime;
                final orderTotalPrice = orderDetails.totalPrice;
                final orderDeliveryAddress =
                    orderDetails.deliveryAddress;
                final List orderItems = orderDetails.items;

                return OrdersList(
                  orderId: orderId,
                  orderStatus: orderStatus,
                  orderDate: orderDate,
                  orderTotalPrice: orderTotalPrice,
                  onOrderTab: () {
                    Navigator.pushNamed(
                        context, RoutesName.orderDetails,
                        arguments: {
                          'orderId': orderId,
                          'totalPrice': orderTotalPrice,
                          'deliveryAddress': orderDeliveryAddress,
                          'paymentType': orderDetails.paymentType,
                          'orderTime': orderTime,
                          'orderDate': orderDate,
                          'status': orderStatus,
                          'items': orderItems
                        });
                  },
                );
              }),
        );
      }
                },
              ),
    );
  }
}
