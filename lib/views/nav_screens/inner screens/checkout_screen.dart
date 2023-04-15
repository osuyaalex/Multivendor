import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor/provider/cart_provider.dart';
import 'package:multivendor/views/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('Buyers');
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text('CheckOut'),
            ),
            body: ListView.builder(
                itemCount: cartProvider.getCartItem.length ,
                itemBuilder: (context, index){
                  final cartData = cartProvider.getCartItem.values.toList()[index];
                  return Card(
                    child: SizedBox(
                      height: 170,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(cartData.imageUrl[0]),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartData.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 3
                                  ),
                                ),
                                Text('\$${cartData.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 3,
                                      color: Colors.orange
                                  ),
                                ),
                                OutlinedButton(
                                    onPressed: null,
                                    child: Text(cartData.size)
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(12.0),
              child: data['address'] == ''?TextButton(
                  onPressed: (){},
                  child: Text('Enter Address')
              ):InkWell(
                onTap: (){
                  EasyLoading.show(status: 'Placing order');
                  cartProvider.getCartItem.forEach((key, value) {
                    final orderId = const Uuid().v4();
                    firebaseFirestore.collection('Orders').doc(orderId).set({
                      'orderId': orderId,
                      'vendorId':value.vendorId,
                      'email':data['email'],
                      'phone no':data['phone no'],
                      'address': data['address'],
                      'buyerId': FirebaseAuth.instance.currentUser!.uid,
                      'full name': data['full Name'],
                      'buyerImage':data['imageUrl'],
                      'productName':value.productName,
                      'productPrice':value.price,
                      'productId':value.productId,
                      'productImage':value.imageUrl,
                      'productSchedule':value.scheduleDate,
                      'productQuantity':value.productQuantity,
                      'orderDate': DateTime.now()
                    }).whenComplete((){
                      setState(() {
                        cartProvider.getCartItem.clear();
                      });
                    });
                    EasyLoading.dismiss();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return MainScreen();
                    }));
                  });

                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Center(
                    child: Text('Place Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const Text("loading");
      },
    );

  }
}
