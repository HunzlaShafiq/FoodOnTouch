import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';
import 'package:fooddelivery/Utils/Components/SimpleTextView.dart';


class MyDetails extends StatefulWidget {
  final dynamic data;
  const MyDetails({super.key,required this.data});

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    String userName=widget.data['userName'];
    String userAddress=widget.data['userAddress'];
    String userNumber=widget.data['userPhoneNumber'];
    String userEmail=widget.data['userEmail'];
    String userImageUrl=widget.data['userImageUrl'];

    nameController.text =userName;
    phoneController.text =userNumber;
    emailController.text = userEmail;
    addressController.text =userAddress;

    final String userId= FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new_sharp,size: 20,)),
        automaticallyImplyLeading: false,
        title: Text("My Details" ,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context, RoutesName.editProfile,arguments: {
              'userId':userId,
              'userName':userName,
              'userImageUrl':userImageUrl,
              'userEmail':userEmail,
              'userPhoneNumber':userNumber,
              'userAddress':userAddress
            });
          }, child: Text('Edit',style: TextStyle(color: Colors.amber,fontSize: 16),))
        ],
      ),
      body: Column(

        children: [
          CircleAvatar(
              backgroundColor: gray3,
              radius:65 ,
              child:ClipOval(
                child: MyNetworkCacheImage(imageUrl: userImageUrl, height: 120, width: 120,boxFit: BoxFit.cover,),
              )
          ),
          SizedBox(height: 20,),
          SimpleTextView(controller: nameController, prefixIcon: Icon(Icons.person_outlined)),
          SizedBox(height: 15,),
          SimpleTextView(controller: emailController, prefixIcon: Icon(Icons.email_outlined)),
          SizedBox(height: 15,),
          SimpleTextView(controller: phoneController, prefixIcon: Icon(Icons.phone)),
          SizedBox(height: 15,),
          SimpleTextView(controller: addressController, prefixIcon: Icon(Icons.location_on_outlined)),

        ],
      ),

    );
  }
}
