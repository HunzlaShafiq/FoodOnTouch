import 'package:flutter/material.dart';

class OrderDetailsBasicInfo extends StatelessWidget {
  final String orderId;
  final String orderStatus;
  final String orderDate;
  final String orderTime;
  final String orderDeliveryAddress;

  const OrderDetailsBasicInfo(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.orderDate,
      required this.orderDeliveryAddress, required this.orderTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 250,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order ID:', style: TextStyle(color: Colors.grey.shade400)),
              Text(orderId,style: TextStyle(
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Status:',
                  style: TextStyle(color: Colors.grey.shade400)),
              Text(
                orderStatus,
                style: TextStyle(
                  color: Colors.green
                ),)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Date:',
                  style: TextStyle(color: Colors.grey.shade400)),
              Text(orderDate)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Time:',
                  style: TextStyle(color: Colors.grey.shade400)),
              Text(orderTime)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Text('Delivery Address:',

                  style: TextStyle(color: Colors.grey.shade400)),
              SizedBox(
                width: 30,
              ),
              Text(
                orderDeliveryAddress,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
