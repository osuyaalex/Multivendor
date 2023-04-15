import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../product_detail/product_detail.dart';
class AllProductScreen extends StatelessWidget {
  final dynamic categoryData;
  const AllProductScreen({Key? key, required this.categoryData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('Products').where('ProductCategory', isEqualTo: categoryData['Category Name']).snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(categoryData['Category Name'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                childAspectRatio: 200/300
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index){
                final productData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ProductDetailScreen(productData: productData,);
                    }));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 170,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(productData['ImageUrlList'][0]), fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(productData['ProductName'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Text('\$${productData['ProductPrice'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              fontSize: 18
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
