import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;


  Future<void> forgetPassword(String email) async{

    auth.sendPasswordResetEmail(email: email).then((value){
      SuccessMessageToast().successToastMessage("Go to mail for reset password");
      Navigator.pop(context);
    }).onError((error,stackTrace){
      ErrorToast().errorToastMessage(error.toString());
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Forget Password!"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 150),
            Center(
              child: Text(
                "Please enter your email address to forget the password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: MyTextField(
                  controller: emailController,
                  hint: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email';
                    } else {
                      return null;
                    }
                  }),
            ),
            SizedBox(height: 90,),
            MYButton(actionText: 'Send Link', onTab:(){
        
              if(_formKey.currentState!.validate()){
        
                forgetPassword(emailController.text.toString());
        
              }
        
        
            })
          ],
        ),
      ),
    );
  }



}
