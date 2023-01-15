import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class AuthController{

  pickImage(ImageSource source)async{
    final ImagePicker _picker = ImagePicker();
    XFile? _file = await _picker.pickImage(source: source);
    if(_file != null){
      await _file.readAsBytes();
    }else{
      print('no image selected');
    }
  }
  signupUsers(String email, String fullName, String phoneNo, String password )async{
    String res = 'Something went wrong';

    try{
      if(email.isNotEmpty && fullName.isNotEmpty && phoneNo.isNotEmpty && password.isNotEmpty){
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       await _firestore.collection('Buyers').doc(cred.user!.uid).set({
         'email': email,
         'password': password,
         'full Name': fullName,
         'phone no': phoneNo,
         'buyer id': cred.user!.uid
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