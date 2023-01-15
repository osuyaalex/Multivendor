import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/views/nav_screens/account.dart';
import 'package:multivendor/views/nav_screens/cart.dart';
import 'package:multivendor/views/nav_screens/explore.dart';
import 'package:multivendor/views/nav_screens/home.dart';
import 'package:multivendor/views/nav_screens/search.dart';

import 'nav_screens/store.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
     HomeScreen(),
    Explore(),
    Store(),
    Cart(),
    Search(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        currentIndex: _currentIndex,
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
          selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/home.svg', width: 30,), label: 'Home',),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/explore.svg',width: 30,), label: 'Explore'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/store.svg',width: 30,), label: 'Store'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/shopping_cart.svg',width: 30,), label: 'Cart'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/search.svg',width: 30,), label: 'Search'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/account.svg',width: 30,), label: 'account'),
          ]
      ),
      body: _screens[_currentIndex],
    );
  }
}
