import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  List<IconData> iconList = [
    Icons.home,
    Icons.message,
    Icons.shopping_cart,
    Icons.person,
  ];

  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppConstants.appTextColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: iconList.map((icon) {
            int index = iconList.indexOf(icon);
            return IconButton(
              icon: Icon(icon),
              color: _bottomNavIndex == index
                  ? AppConstants.appScendoryColor
                  : Colors.grey,
              onPressed: () => setState(() => _bottomNavIndex = index),
            );
          }).toList(),
        ),
      ),
    );
  }
}
