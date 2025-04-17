import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final townController = TextEditingController();
  ValueNotifier<bool> checkBoxValue =ValueNotifier<bool>(false);

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
                "Address",
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
                        "Delivery",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                        controller: addressController,
                        hint: "House address",
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
                        "Town",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                        controller: townController,
                        hint: "Town",
                        prefixIcon: const Icon(Icons.location_city_sharp),
                        validator: (value) {
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "City",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    MyTextField(
                        controller: cityController,
                        hint: "City",
                        prefixIcon: const Icon(Icons.location_city_sharp),
                        validator: (value) {
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: checkBoxValue,
                              builder: (context,value,child){
                                return Checkbox(
                                  value: checkBoxValue.value,
                                  onChanged: (value) {
                                    checkBoxValue.value  = !checkBoxValue.value;
                                  },
                                  activeColor: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                );
                              }
                          )
                          ,
                          const Text("Billing address same as delivery",style: TextStyle(fontWeight: FontWeight.w700),)
        
                        ],
        
                      ),
                    ),
                    const SizedBox(height: 10,),
        
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Consumer<ProfileProvider>(
                builder:(context,profileProviderValues,child){
                  return MYButton(
                    actionText: 'Save',
                    onTab: (){
                      final newAddress= "${addressController.text.toString()},${townController.text.toString()},${cityController.text.toString()}.";

                      profileProviderValues.addNewAddress(newAddress,context);
                    },
                    loading: profileProviderValues.isLoading,
                  );
                }
    )
          ],
        ),
      ),
    );
  }
}
