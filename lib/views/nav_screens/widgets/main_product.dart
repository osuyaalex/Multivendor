import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/views/product_detail/product_detail.dart';

class MainProducts extends StatelessWidget {
  const MainProducts({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance.collection('Products').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        return SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, _){
              return const SizedBox(
                width: 15,
              );
            },
            itemBuilder: (context, index){
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
            },


          ),
        );
      },
    );
  }
}
