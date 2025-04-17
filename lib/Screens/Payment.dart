import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/MyForwardButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  @override
  void dispose() {

    super.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Payment",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: gray3, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Card Number",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                        controller: addressController,
                        hint: "*** *** *** 356",
                        prefixIcon: const Icon(Icons.place_outlined),
                        validator: (value) {
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Expiration",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                        controller: cityController,
                        hint: "MM/DD",
                        prefixIcon: const Icon(Icons.location_city_sharp),
                        validator: (value) {
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child:Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal'),
                              Text('5,000'),

                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Taxes'),
                              Text('Free'),

                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total'),
                              Text('5,000'),

                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    )
                  )
                )


                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            MyForwardButton(
                content: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Payment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(width: 15,),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
                onTab: (){})
          ],
        ),
      ),
    );
  }
}
