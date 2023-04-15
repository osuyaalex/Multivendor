import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin {
@override
bool get wantKeepAlive => true;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final List<String> _categoryList = [];
_getCategories(){
  return _firestore.collection('Categories').get().then((QuerySnapshot querySnapshot){
    querySnapshot.docs.forEach((doc) {
      setState(() {
        _categoryList.add(doc['Category Name']);
      });
    });
  });
}

String formattedDate(date){
  final outputDateFormat = DateFormat('dd/MM/yyyy');
  final outputDate = outputDateFormat.format(date);
  return outputDate;
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
  super.build(context);
  final ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter product name';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Enter product name'
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter product price';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productPrice: double.parse(value));
                },
                decoration: const InputDecoration(
                    labelText: 'Enter product price',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter product quantity';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productQuantity: int.parse(value));
                },
                decoration: const InputDecoration(
                  labelText: 'Enter product quantity',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                hint: const Text('select category'),
                  items: _categoryList.map<DropdownMenuItem<dynamic>>((e){
                    return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value){
                  setState(() {
                    _productProvider.getFormData(productCategory: value);
                  });
                  }
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter product description';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productDescription: value);
                },
                maxLength: 800,
                maxLines: 8,
                decoration:  InputDecoration(
                  labelText: 'Enter Product description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 TextButton(
                     onPressed: (){
                       showDatePicker(
                           context: context,
                           initialDate: DateTime.now(),
                           firstDate: DateTime.now(),
                           lastDate: DateTime(5000),
                       ).then((value){
                         setState(() {
                           _productProvider.getFormData(scheduleDate: value);
                         });
                       });
                     },
                     child: const Text('Schedule')
                 ),
                  _productProvider.productData['scheduleDate']!= null ?
                  Text(formattedDate(_productProvider.productData['scheduleDate'])
                  ):Text('dd/mm/yyyy')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
