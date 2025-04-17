import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final userLogin = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (userLogin == null) {
        Navigator.pushReplacementNamed(context, RoutesName.logIn);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.allScreens);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                        "Food On Touch",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ).animate().fade(),
            SizedBox(
              height: 80,
            ),
            Lottie.asset(
                "assets/loading.json",
                height: 100,
                width: 100
            )
          ],
        ),
      ),
    );
  }
}
