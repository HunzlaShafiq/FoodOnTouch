import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/CategoriesProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/FetchProductsProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:fooddelivery/Provider/FavouriteProvider.dart';
import 'package:fooddelivery/Provider/InternetConnectionCheckerProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/FirebaseDataProviders/OrdersProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CategoriesProvider()),
        ChangeNotifierProvider(create: (_)=>FetchProductsProvider()),
        ChangeNotifierProvider(create: (_)=>CartProvider()),
        ChangeNotifierProvider(create: (_)=>ProfileProvider()),
        ChangeNotifierProvider(create: (_)=>FavouriteProvider()),
        ChangeNotifierProvider(create: (_)=>OrdersProvider()),
        ChangeNotifierProvider(create: (_)=>BottomNavProvider()),
        ChangeNotifierProvider(create: (_)=>InternetConnectionCheckerProvider()),
      ],

      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
                Theme.of(context).textTheme
            )
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ) ,
    );

  }
}

