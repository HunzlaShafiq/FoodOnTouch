import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Provider/InternetConnectionCheckerProvider.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {

  final dynamic data;
  const ChangePassword({super.key,required this.data});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser;

  bool loading = false;
  

  Future<void> changePassword(String email, currentPassword,newPassword) async{

    setState(() {
      loading = true;
    });
    var credential =  EmailAuthProvider.credential(email: email, password: currentPassword);

    currentUser!.reauthenticateWithCredential(credential)
        .then((value){

          currentUser!.updatePassword(newPassword).then((onValue){
            setState(() {
              loading = false;
            });
            SuccessMessageToast().successToastMessage("Successfully Change Password");

          })
          .onError((e,s){
            setState(() {
              loading = false;
            });
            ErrorToast().errorToastMessage(e.toString());
          });

    })
        .catchError((error){
      setState(() {
        loading = false;
      });
          ErrorToast().errorToastMessage(error.toString());

    });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final checkInternet = Provider.of<InternetConnectionCheckerProvider>(context,listen: true);

    final email = widget.data['userEmail'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            SizedBox(height: 120,),
            MyTextField(
                controller: currentPassword,
                hint: 'Current Password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                validator: (val){}),
            SizedBox(height: 15,),
        
            MyTextField(
                controller: newPassword,
                hint: 'New Password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                validator: (val){}),
        
            SizedBox(height: 15,),
        
            MyTextField(
                controller: confirmPassword,
                hint: 'Confirm Password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                validator: (val){}),
        
            SizedBox(height: 35,),
            MYButton(actionText: "Change Password",
                loading: loading,
                onTab: ()async{

             if(await checkInternet.checkInternetConnection(context)){
               if(newPassword.text == confirmPassword.text){

                 changePassword(email, currentPassword.text.toString(), newPassword.text.toString());
               }
               else{
                 newPassword.clear();
                 confirmPassword.clear();
                 ErrorToast().errorToastMessage("confirm password no match");
               }
             }

        
            })
        
          ],
        ),
      ),
    );
  }
}
