import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogOutScreen extends StatelessWidget {
   VendorLogOutScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: ()async{
            await _auth.signOut();
          },
          child: Text('signout')
      )
    );
  }
}
