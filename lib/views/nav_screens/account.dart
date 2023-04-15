import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/views/auth/login_screen.dart';
class Account extends StatelessWidget {
   Account({Key? key}) : super(key: key);
  CollectionReference buyers = FirebaseFirestore.instance.collection('Buyers');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<DocumentSnapshot>(
      future: buyers.doc(FirebaseAuth.instance.currentUser?.uid).get(),
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
          return  Scaffold(
            appBar: AppBar(
              actions:  const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(Icons.sunny, color: Colors.black,),
                )
              ],
              title: Text('Profile'.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight:FontWeight.bold,
                    letterSpacing: 4,
                    fontSize: 25
                ),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                   CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(data['image Url']),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data['full Name'],
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(data['email'],
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Cart'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.shopping_cart_checkout),
                    title: Text('Orders'),
                  ),
                   ListTile(
                    onTap: ()async{
                      await _firebaseAuth.signOut().whenComplete((){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const LoginScreen();
                        }));
                      });
                    },
                    leading: Icon(Icons.logout),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );


  }
}
