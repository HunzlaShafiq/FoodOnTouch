import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Components/OrderDetailsBasicInfo.dart';
import 'package:fooddelivery/Utils/Components/OrderDetailsItems.dart';

class OrdersDetails extends StatefulWidget {
  final dynamic data;

  OrdersDetails({super.key,required this.data});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {

  @override
  Widget build(BuildContext context) {

    final orderDetails = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailsBasicInfo(
                  orderId:  orderDetails['orderId'],
                  orderStatus: orderDetails['status'],
                  orderDate: orderDetails['orderDate'],
                  orderDeliveryAddress: orderDetails['deliveryAddress'],
                  orderTime: orderDetails['orderTime']
              ),
              SizedBox(height: 20,),
              Text('Order Items',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              OrderDetailsItems(itemList: orderDetails['items'],totalPrice: orderDetails['totalPrice'],)

            ],
          )),
    );
  }
}