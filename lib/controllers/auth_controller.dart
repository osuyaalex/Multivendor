import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final ImagePicker _picker = ImagePicker();
final FirebaseStorage _storage = FirebaseStorage.instance;

class AuthController{


  uploadProfilePictureToStorage(Uint8List? image)async{
   Reference ref =  _storage.ref().child('Profile').child(_auth.currentUser!.uid);
   UploadTask uploadTask =ref.putData(image!);
   TaskSnapshot taskSnapshot = await uploadTask;
   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
   return downloadUrl;
  }

  pickImage(ImageSource source)async{

      XFile? _file = await _picker.pickImage(source: source);
      if(_file != null){
        return _file.readAsBytes();
      }else{
        print('no image selected');
      }

  }
  signupUsers(String email, String fullName, String phoneNo, String password, Uint8List? image )async{
    String res = 'Something went wrong';

    try{
      if(email.isNotEmpty && fullName.isNotEmpty && phoneNo.isNotEmpty && password.isNotEmpty && image != null){
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    String profileImageUrl =await uploadProfilePictureToStorage(image);
       await _firestore.collection('Buyers').doc(cred.user!.uid).set({
         'email': email,
         'password': password,
         'full Name': fullName,
         'phone no': phoneNo,
         'buyer id': cred.user!.uid,
         'image Url': profileImageUrl
       });
     res = 'success';
      }

      else{
        res = 'These Fields Must Not Be Empty';
      }
    }catch(e){
      res =(e.toString());
    }
    return res;
  }

  loginUsers(String email, String password)async{
    String res = 'Something Went Wrong';
    try{
      if(email.isNotEmpty && password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = 'success';
      }else{
        res = 'please fill in all fields';
      }
    }catch(e){
      res = e.toString();
    }
    return res;
  }

}