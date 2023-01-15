import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendor/controllers/auth_controller.dart';
import 'package:multivendor/utils/snackbar.dart';
import 'package:multivendor/views/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  late String email;
  late String fullName;
  late String phoneNo;
  late String password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool  _switchPic = true;
  Uint8List? _image;

  signUp()async{
    setState(() {
      _isLoading = true;
    });
   if(_globalKey.currentState!.validate()){
      await _authController.signupUsers(
         email,
         fullName,
         phoneNo,
         password
     ).whenComplete((){
       setState(() {
         _globalKey.currentState!.reset();
         _isLoading = false;
       });
      });
      return snack(context, 'Account Created');
   }else{
     setState(() {
       _isLoading = false;
     });
     return snack(context, 'Fields Must Not Be Empty');
   }
  }

  selectGalleryImage()async{
    Uint8List? _im=await _authController.pickImage(ImageSource.gallery);
    setState(() {
      _image = _im;
    });
  }
  selectCameraImage()async{
    Uint8List? _im=await _authController.pickImage(ImageSource.camera);
    setState(() {
      _image = _im;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text('Create Customer Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children:  [
                          _image != null ? CircleAvatar(
                            radius: 44,
                            backgroundImage: MemoryImage(_image!),
                          ):const CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.black,
                          ),
                          Positioned(
                            right: 20,
                              bottom: 18,
                              child: _switchPic ? IconButton(
                                  onPressed: (){
                                    selectGalleryImage();
                                  },
                                  icon:const Icon(
                                    CupertinoIcons.photo,
                                    color: Colors.white,
                                  )
                              ):IconButton(
                                  onPressed: (){
                                    selectCameraImage();
                                  },
                                  icon:const Icon(
                                    CupertinoIcons.camera,
                                    color: Colors.white,
                                  )
                              )
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _switchPic = !_switchPic;
                            });
                          },
                          child: Stack(
                            children:  [
                              const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.black,
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: _switchPic ?const Icon(
                                    CupertinoIcons.camera,
                                  color: Colors.white,

                                ): const Icon(CupertinoIcons.photo,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v){
                      if(v!.isEmpty){
                        return 'please email must not be empty';
                      }else{
                        null;
                      }
                    },
                    onChanged: (v){
                      email = v;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Email'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v){
                      if(v!.isEmpty){
                        return 'please full name must not be empty';
                      }else{
                        null;
                      }
                    },
                    onChanged: (v){
                      fullName = v;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Enter Full name'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v){
                      if(v!.isEmpty){
                        return 'please phone no must not be empty';
                      }else{
                        null;
                      }
                    },
                    onChanged: (v){
                      phoneNo = v;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Enter Phone No.'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: _obscurePassword,
                    validator: (va){
                      if(va!.isEmpty){
                        return 'please password must not be empty';
                      }else{
                        null;
                      }
                    },
                    onChanged: (v){
                      password = v;
                    },
                    decoration:  InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: _obscurePassword ?const Icon(Icons.visibility)
                              :const Icon(Icons.visibility_off),
                      ),
                        labelText: 'Enter Password'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      signUp();
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black
                      ),
                      child:  Center(
                        child: _isLoading == true? const CircularProgressIndicator(color: Colors.white,):
                        const Text('Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.white,
                            letterSpacing: 4
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text('Already have an account?',
                        style: TextStyle(
                          fontSize: 20
                        ) ,
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return LoginScreen();
                            }));
                          },
                          child:   const Text('Login',
                            style: TextStyle(
                                fontSize: 20
                            ) ,
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
