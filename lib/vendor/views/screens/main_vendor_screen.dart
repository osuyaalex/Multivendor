import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/views/nav_screens/earnings_screen.dart';
import 'package:multivendor/views/nav_screens/edit_product_screen.dart';
import 'package:multivendor/views/nav_screens/vendor_logout_screen.dart';
import 'package:multivendor/views/nav_screens/vendor_order_screen.dart';

import '../../../views/nav_screens/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({Key? key}) : super(key: key);

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int changeIcon = 0;
  List<Widget> pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogOutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:  changeIcon,
        unselectedItemColor: Colors.black,
          selectedItemColor: Colors.grey,
          onTap: (value){
          setState(() {
            changeIcon=value;
          });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar,), label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.upload,), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.edit,), label: 'Edot'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart,), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.logout,), label: 'Log Out'),
          ]
      ),
      body: pages[changeIcon],
    );

  }
}
