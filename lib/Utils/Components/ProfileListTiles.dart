
import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';

class ProfileListTiles extends StatelessWidget {

  final String text;
  final VoidCallback onTab;
  final IconData icon;


  const ProfileListTiles({super.key, required this.text, required this.onTab, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: ListTile(
        title: Text(text),
        leading: CircleAvatar(
            backgroundColor: grayMoreLight,
            radius: 22,
            child: Icon(icon)),
        trailing: Icon(Icons.arrow_forward_ios_rounded,size: 18,),
      ),
    );
  }
}
