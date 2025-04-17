import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';

class CheckOutAddress extends StatelessWidget {
  final String customerAddress;
  final VoidCallback editAddress;

  CheckOutAddress({
    super.key,
    required this.customerAddress,
    required this.editAddress
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: gray3),
          child: Column(
            children: [
              ListTile(
                title: Text(customerAddress),
                leading: Icon(Icons.location_on),
              ),
              ListTile(
                title: Text("30 - 40 min."),
                leading: Icon(Icons.access_time_filled),
              )
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 96,
        right: 7,
        child: InkWell(
          onTap: editAddress,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(100))),
            child: Center(
                child: Icon(
              Icons.edit,
              size: 20,
            )),
          ),
        ),
      )
    ]);
  }
}
