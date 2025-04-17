import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey();

  final _signUpAuth = FirebaseAuth.instance;



  final userRef = FirebaseFirestore.instance.collection('Users');

  bool loading =false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    phoneNoController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150,),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text('SignUp',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
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
              const SizedBox(height: 15,),
              MyTextField(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please Enter Password';
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
                  signUp();
                }
              },
              loading: loading,
              actionText: 'SignUp',
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  const Text("I Already have an account!"),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, RoutesName.logIn);
                      },
                      child: const Text('LogIn',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)))
                ],
              ),
            )
        
          ],
        ),
      ),
    );
  }

  Future<void>signUp() async{
    setState(() {
      loading= true;
    });
    final userEmail= emailController.text.toString();
    final userPassword= passwordController.text.toString();
    final userName= userNameController.text.toString();
    final userNumber= phoneNoController.text.toString();
    final userAddress= addressController.text.toString();
    _signUpAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password:userPassword)
        .then((onValue){
          final userId = FirebaseAuth.instance.currentUser!.uid;

          userRef.doc(userId).set({
            'userId': userId,
            'userName':userName,
            'userAddress': userAddress,
            'userPhoneNo': userNumber,
            'userEmail' : userEmail,
            'userProfileImage':''
          }).then((value)
          {
            setState(() {
              loading= false;
            });

            final id = DateTime.now().millisecondsSinceEpoch.toString() ;
            userRef.doc(userId).collection('Addresses').doc(id).set({
              'id':id,
              'address':userAddress
            });

            SuccessMessageToast().successToastMessage("Successfully SignUp");
            Navigator.pushReplacementNamed(context, RoutesName.logIn);
          });





    })
        .onError((handleError,stackTrace){
      setState(() {
        loading= false;
      });
      ErrorToast().errorToastMessage(handleError.toString());

    });

  }





}

