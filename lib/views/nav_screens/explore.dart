import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/views/nav_screens/inner%20screens/all_product_screen.dart';
class Explore extends StatelessWidget {
   Explore({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance.collection('Categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Categories',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            letterSpacing: 3
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black,));
          }

          return Padding(
              padding:  const EdgeInsets.all(12),
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final categoryData = snapshot.data!.docs[index];
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return AllProductScreen(categoryData: categoryData,);
                      }));
                    },
                    leading: Image.network(categoryData['image']),
                    title: Text(categoryData['Category Name']),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
