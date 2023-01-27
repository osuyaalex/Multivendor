
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController{
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  uploadVendorImageToStorage(Uint8List? image)async{
    Reference ref =_storage.ref().child('Vendor Store').child(_auth.currentUser!.uid);
   UploadTask uploadTask= ref.putData(image!);
   TaskSnapshot snapshot =await uploadTask;
   String downloadUrl =await snapshot.ref.getDownloadURL();
   return downloadUrl;

  }
  pockStoreImage(ImageSource source)async{
    XFile? _xfile = await _picker.pickImage(source: source);
    if(_xfile != null){
      return await _xfile.readAsBytes();
    }else{}
  }
  saveVendor(String businessName, String email, String phoneNo, String countryValue, String stateValue, String cityValue, String taxValue, String? taxNumber, Uint8List? image)async{
    String res = 'some error occured';
    try{
       String storeImage =await uploadVendorImageToStorage(image);
        await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set(
            {
              'businessName': businessName,
              'email':email,
              'phoneNumber': phoneNo,
              'country': countryValue,
              'state':stateValue,
              'city': cityValue,
              'taxOptions': taxValue,
              'taxNumber': taxNumber,
              'image': storeImage,
              'approved':false,
              'vendorId': _auth.currentUser!.uid
            }
        );
        res = 'success';

    }catch(e){
      res =e.toString();
    }
    return res;
  }
}