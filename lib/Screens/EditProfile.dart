import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Utils/Contants/Constants.dart';
import '../Utils/Components/SuccessMessage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  final dynamic data;

  EditProfile({super.key, required this.data
    });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey();

  bool loading = false;

  File? _image;
  final imagePicker = ImagePicker();
  final userRef = FirebaseFirestore.instance.collection('Users');
  String userProfileImageUrl ='';


  Future <void> pickProfileImage(String userId) async{
    final pickedImage =await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        _image=File(pickedImage.path);

      });

      firebase_storage.Reference userImageRef = firebase_storage.FirebaseStorage.instance.ref("/UsersImages/$userId");
      firebase_storage.UploadTask uploadUserImage = userImageRef.putFile(_image!.absolute);
      Future.value(uploadUserImage)
          .then((value) async{
        String updatedUserProfileImageUrl= await userImageRef.getDownloadURL();

        try{
          userRef.doc(widget.data['userId']).update({
            'userProfileImage':updatedUserProfileImageUrl
          });
        }catch(e){
          return "$e";
        }



      })
          .onError((error,stackTrace){

            ErrorToast().errorToastMessage(error.toString());
            return null;

      });

    }






  }




  @override
  Widget build(BuildContext context) {

    String userName=widget.data['userName'];
    String userAddress=widget.data['userAddress'];
    String userNumber=widget.data['userPhoneNumber'];
    String userEmail=widget.data['userEmail'];
    String userImageUrl=widget.data['userImageUrl'];

    addressController.text=userAddress;
    emailController.text=userEmail;
    phoneNoController.text=userNumber;
    userNameController.text=userName;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: const Icon(Icons.arrow_back_ios_new_sharp,size: 20,)),

        title: const Text('Edit Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: gray3,
                    radius:70 ,
                    child:ClipOval(
                      child: _image==null ? userImageUrl =='' ? const Icon(Icons.person,size: 35,):
                      MyNetworkCacheImage(imageUrl: userImageUrl, height: 150, width: 150,boxFit: BoxFit.cover)
                          :Image.file(_image!.absolute,alignment: Alignment.center,height: 150,width: 150,fit: BoxFit.cover,),
                    ),
                  ),
                ),
                Positioned(
                  right: 95,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: (){
                      pickProfileImage(widget.data['userId']);
                      },
                    child: const CircleAvatar(
                      backgroundColor: gray3,
                      radius:30 ,
                      child: Icon(Icons.edit,size: 24,),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const SizedBox(height: 50,),
            Form(
                key: _formKey,
                child: Column(children: [
                  MyTextField(
                    hint: 'UserName',
                    controller: userNameController,
                    prefixIcon:const Icon(Icons.person_outlined),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Username';
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    hint: 'E-mail',
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon:const Icon(Icons.email_outlined),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Email';
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    hint: 'Phone Number',
                    controller: phoneNoController,
                    prefixIcon:const Icon(Icons.local_phone_outlined),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Phone Number';
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    hint: 'Address',
                    controller: addressController,
                    prefixIcon:const Icon(Icons.location_on_outlined),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Address';
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),

                ],)),
            const SizedBox(height: 50,),
            MYButton(
              onTab: (){
                if(_formKey.currentState!.validate()){

                  String updatedUserAddress= addressController.text;
                  String updatedUserEmail=emailController.text;
                  String updatedUserNumber=phoneNoController.text;
                  String updatedUserName=userNameController.text;

                   updateUserProfile(updatedUserName, updatedUserAddress, updatedUserNumber, updatedUserEmail);
                }
              },
              loading: loading,
              actionText: 'Save',
            ),

          ],
        ),
      ),
    );
  }

  Future<void> updateUserProfile(String userName,String userAddress, String userNumber, String userEmail) async{
    setState(() {
      loading= true;
    });

    userRef.doc(widget.data['userId']).update({
      'userName':userName,
      'userAddress': userAddress,
      'userPhoneNo': userNumber,
      'userEmail' : userEmail,
    })
        .then((value)
    {
      setState(() {
        loading= false;
      });
      SuccessMessageToast().successToastMessage("Successfully Save");
      final profileProvider =Provider.of<ProfileProvider>(context,listen: false);
      profileProvider.fetchProfileData();
      Navigator.pop(context);

    })
        .onError((handleError,stackTrace){

      setState(() {
        loading= false;
      });
      
      ErrorToast().errorToastMessage(handleError.toString());
      
      
    });
    

  }


}
