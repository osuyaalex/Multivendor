import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendor/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesScreen extends StatefulWidget {
  ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
 final ImagePicker _picker = ImagePicker();
 final FirebaseStorage _storage = FirebaseStorage.instance;

 final List<File> _image = [];
 final List<String>_imageUrlList = [];

  chooseImage()async{
    final pockedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pockedFile ==null){
      print('no Image');
    }else{
      setState(() {
        _image.add(File(pockedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _provider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
      GridView.builder(
        shrinkWrap: true,
        itemCount: _image.length+1,
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 6,
            childAspectRatio:3/3
          ),
          itemBuilder: (context, index){
          return Center(
            child:index == 0? IconButton(
                onPressed: (){
                  chooseImage();
                },
                icon: Icon(Icons.add)
            ): Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(_image[index-1]))
              ),
            ) ,
          );
          }
      ),
      const SizedBox(
        height: 15,
      ),
      TextButton(
          onPressed: ()async{
            setState(() {
              EasyLoading.show();
            });
            for(var img in _image){                            //to generate unique id for each image
             Reference ref = _storage.ref().child('productImage').child(Uuid().v4());
             await ref.putFile(img).whenComplete(()async{
               await ref.getDownloadURL().then((value){
                 setState(() {
                   _imageUrlList.add(value);
                 });
               });
             });
            }
            setState(() {
              _provider.getFormData(imageUrlList: _imageUrlList);
              EasyLoading.dismiss();
            });
          },
          child: _image.isNotEmpty?const Text('Upload'):const Text('')
      )
      ],
    );
  }
}
