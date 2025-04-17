import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import'package:flutter/material.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:provider/provider.dart';



class AllScreens extends StatefulWidget {
  const AllScreens({super.key});

  @override
  State<AllScreens> createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {



  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context,navProviderValue,child){
        return Scaffold(
          extendBody: true,
          body: navProviderValue.pages[navProviderValue.index],
          bottomNavigationBar: FloatingNavbar(
              currentIndex: navProviderValue.index,
              backgroundColor: Colors.grey.shade300,
              elevation: 0,
              borderRadius: 30,
              itemBorderRadius: 100,
              selectedBackgroundColor: Colors.amberAccent,
              unselectedItemColor: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              padding: const EdgeInsets.only(bottom: 5,top: 5),
              onTap:navProviderValue.changeIndex ,
              items: [
                FloatingNavbarItem(icon: Icons.home_filled),
                FloatingNavbarItem(icon: Icons.favorite_border),
                FloatingNavbarItem(icon: Icons.shopping_cart_outlined),
                FloatingNavbarItem(icon: Icons.person_outline),
              ]
          ),
        );
      },
    );
  }
}
