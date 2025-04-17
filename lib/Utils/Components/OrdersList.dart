import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  final String orderId;
  final String orderStatus;
  final String orderDate;
  final int orderTotalPrice;
  final VoidCallback onOrderTab;

  const OrdersList(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.orderDate,
      required this.orderTotalPrice, required this.onOrderTab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: onOrderTab,
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Id:',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    Text(
                      orderId,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    Text(
                      orderStatus,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Date:',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    Text(
                      orderDate,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    Text(
                      "RS. $orderTotalPrice",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
