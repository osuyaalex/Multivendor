import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter product name'
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Enter product price',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
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
                  onChanged: (value){}
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
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
                children: [
                 TextButton(
                     onPressed: (){
                       showDatePicker(
                           context: context,
                           initialDate: DateTime.now(),
                           firstDate: DateTime.now(),
                           lastDate: DateTime(5000),
                       );
                     },
                     child: const Text('Schedule')
                 )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
