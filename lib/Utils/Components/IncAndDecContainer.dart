import 'package:flutter/material.dart';

class IncAndDecContainer extends StatelessWidget {
  final VoidCallback onTab;
  final IconData icon;
  const IncAndDecContainer({super.key, required this.onTab, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                offset: Offset(4, 3)),
          ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(100)
        ),
        child: Center(
            child: Icon(
              icon,
              color: Colors.grey,size: 20,
            )
        ),
      ),
    );
  }
}
