import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/LoginAndLogoutServices/LoginAndLogoutServices.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyTextField.dart';
import 'package:fooddelivery/Utils/Components/SuccessMessage.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey();

  final _logInAuth = FirebaseAuth.instance;

  bool loading =false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150,),
            Form(
              key: _formKey,
                child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('LogIn',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              const SizedBox(height: 50,),
              MyTextField(
                hint: 'E-mail',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
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
                hint: 'Password',
                obscureText: true,
                controller: passwordController,
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
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(

                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, RoutesName.forgetPassword);
                  }, child: Text("Forget Password",style: TextStyle(color: Colors.black),)),
                ),
              )
            ],)),
            const SizedBox(height: 50,),

            MYButton(
              onTab: () {
                if(_formKey.currentState!.validate()){
                  logIn();



                }
              },
              loading: loading,
              actionText: 'LogIn',
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  const Text("I don't have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RoutesName.signUp);
                    },
                      child: const Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)))
                ],
              ),
            )
        
          ],
        ),
      ),
    );
  }

  Future<void> logIn() async{
    setState(() {
      loading =true;
    });

    final String userEmail = emailController.text.toString();
    final String userPassword = passwordController.text.toString();

    _logInAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword)
        .then((onValue){
          setState(() {
            loading =false;
          });

          //this refresh all data according to new users
          LoginAndLogoutServices().userLogIn(context);

          SuccessMessageToast().successToastMessage("Successfully LogIn");
          Navigator.pushReplacementNamed(context, RoutesName.allScreens);

    })
        .onError((error,stackTrace){

      setState(() {
        loading =false;
      });
      ErrorToast().errorToastMessage(error.toString());

    });

  }
}
