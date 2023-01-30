import 'package:flutter/material.dart';
import 'package:multivendor/views/nav_screens/upload%20tab%20Screens/attribute.dart';
import 'package:multivendor/views/nav_screens/upload%20tab%20Screens/general_tab_screen.dart';
import 'package:multivendor/views/nav_screens/upload%20tab%20Screens/images.dart';
import 'package:multivendor/views/nav_screens/upload%20tab%20Screens/shipping.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          bottom: const TabBar(
              tabs: [
                Tab(child: Text('general',),),
                Tab(child: Text('ship'),),
                Tab(child: Text('Attribute'),),
                Tab(child: Text('Images'),),
              ],
          ),
        ),
        body: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributeScreen(),
              ImagesScreen()
            ]
        ),
      ),
    );
  }
}
