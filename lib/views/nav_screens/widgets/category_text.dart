import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/views/nav_screens/widgets/home_products.dart';
import 'package:multivendor/views/nav_screens/widgets/main_product.dart';

class CategoryText extends StatefulWidget {
   const CategoryText({Key? key}) : super(key: key);

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance.collection('Categories').snapshots();

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children:  [
          const Text('Categories',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),
          ),
      StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          final categoryData = snapshot.data!.docs[index];
                          return ActionChip(
                              onPressed: (){
                                setState(() {
                                  selectedCategory = categoryData['Category Name'];
                                });
                              },
                              backgroundColor: Colors.black,
                              label: Text(categoryData['Category Name'],
                                style: const TextStyle(
                                    color: Colors.white
                                ),
                              )
                          );
                        }
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_forward_ios)
                )
              ],
            ),
          );
        },
      ),
          selectedCategory != null ?HomeProducts(categoryName: selectedCategory!):
              const MainProducts()
        ],
      ),
    );
  }
}
