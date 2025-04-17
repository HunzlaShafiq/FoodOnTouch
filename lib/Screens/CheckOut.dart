import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/Models/CartItemModel.dart';
import 'package:fooddelivery/FirebaseDataProviders/OrdersProvider.dart';
import 'package:fooddelivery/Utils/Components/CheckOutAddress.dart';
import 'package:fooddelivery/Utils/Components/CheckOutItemContainer.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyForwardButton.dart';
import 'package:provider/provider.dart';
import '../Routes/Routes.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {

    final orderProvider = Provider.of<OrdersProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    String paymentMethod= "Cash On Delivery";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CheckOut",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Consumer<ProfileProvider>(
            builder: (context, profileProviderValues, child) {
              return CheckOutAddress(
                customerAddress:
                         profileProviderValues.selectAddress ==''?profileProviderValues.profileData['userAddress']: profileProviderValues.selectAddress,
                editAddress: () {
                  getNewAddress(context, profileProviderValues.addressesList, profileProviderValues.profileData['userAddress']);
                },
              );
            },
          ),
          CheckOutItemContainer(editCheckOutItems: () {
            Navigator.pop(context);
          }),
          Stack(alignment: Alignment.topRight, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: gray3),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        paymentMethod,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  leading: Icon(Icons.payment),
                ),
              ),
            ),
            Positioned(
              right: 7,
              child: InkWell(
                onTap: () {
                  ErrorToast().errorToastMessage('Cash on Delivery');
                },
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
          ]),
          MyForwardButton(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place Order",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )
                ],
              ),
              onTab: () {
                final List<CartItemModel> cartItemsList = cartProvider.cartItemsList;
                final int totalPrice = cartProvider.totalPrice;
                final String deliveryAddress = profileProvider.selectAddress=='' ? profileProvider.profileData['userAddress'] : profileProvider.selectAddress;
                final String paymentType = paymentMethod;

                List itemsList =[];

                for(var getId in cartItemsList){
                  itemsList.add({
                    'id':getId.id,
                    'itemName':getId.itemName,
                    'itemQuantity':getId.itemQuantity,
                    'itemSize' :getId.itemSize,
                    'itemImageUrl':getId.itemImageUrl
                  });
                }


                orderProvider.addOrders(totalPrice, deliveryAddress, paymentType, itemsList,context);


              }),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }

  void getNewAddress(BuildContext context ,List addresses,String currentAddress) {



    String? currentAdd = currentAddress;

    List<String> addressList = [];

    for(var getAddress in addresses)
      {
       addressList.add(getAddress['address']);
      }

    showModalBottomSheet(
        context: context,
        builder: (context) {

          return StatefulBuilder(builder: (context,setState){
            return BottomSheet(
                onClosing: () {},
                builder: (context) {
                  return Container(
                    height: 300,

                    child: Column(

                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, RoutesName.address);
                              },
                              child: Text(
                                'Add New',
                                style: TextStyle(color: Colors.orangeAccent),
                              )),
                        ),
                        Text('Addresses',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical:10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  menuMaxHeight: 170,
                                  isExpanded: true,
                                  value: currentAdd,
                                  onChanged: (String? val) {
                                    setState(() {
                                      currentAdd =val!;
                                    });
                                  },
                                  items: addressList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(width: 10),
                                          Expanded(child: Text(value,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                        ],
                                      ),
                                    );
                                  }).toList()
                                ),
                              ),
                            )
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Consumer<ProfileProvider>(
                          builder: (context,ProfileProviderValues,child)
                            {
                              return MYButton(actionText: "Confirm", onTab: (){

                                ProfileProviderValues.thisIsSelectedAddress(currentAdd!);


                                Navigator.pop(context);
                              });
                            },
                        ),


                      ],
                    ),
                  );
                });
          });


        });
  }
}
