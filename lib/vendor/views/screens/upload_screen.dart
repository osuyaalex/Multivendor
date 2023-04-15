import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor/provider/product_provider.dart';
import 'package:multivendor/vendor/views/screens/main_vendor_screen.dart';
import 'package:multivendor/vendor/views/screens/upload%20tab%20Screens/attribute.dart';
import 'package:multivendor/vendor/views/screens/upload%20tab%20Screens/general_tab_screen.dart';
import 'package:multivendor/vendor/views/screens/upload%20tab%20Screens/images.dart';
import 'package:multivendor/vendor/views/screens/upload%20tab%20Screens/shipping.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
   UploadScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _provider = Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _globalKey,
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

          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: ()async{
                  EasyLoading.show();
               if(_globalKey.currentState!.validate()){
                 final productId = Uuid().v4();
                 await _firestore.collection('Products').doc(productId).set(
                     {
                       'ProductId': productId,
                       'ProductName':_provider.productData['productName'],
                       'ProductPrice':_provider.productData['productPrice'],
                       'ProductQuantity':_provider.productData['productQuantity'],
                       'ProductCategory':_provider.productData['productCategory'],
                       'ProductDescription':_provider.productData['productDescription'],
                       'ImageUrlList':_provider.productData['imageUrlList'],
                       'ProductShipping':_provider.productData['productShipping'],
                       'ChargeShipping':_provider.productData['ChargeShipping'],
                       'brandName':_provider.productData['brandName'],
                       'sizeList':_provider.productData['sizeList'],
                       'scheduleDate':_provider.productData['scheduleDate'],
                       'vendorId':FirebaseAuth.instance.currentUser!.uid,
                       'approved': false
                     }).whenComplete((){
                       EasyLoading.dismiss();
                       _provider.clearData();
                       _globalKey.currentState!.reset();
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return const MainVendorScreen();
                       }));
                 });
               }
                },
                child: Text('Save')
            ),
          ),
        ),
      ),
    );
  }
}
