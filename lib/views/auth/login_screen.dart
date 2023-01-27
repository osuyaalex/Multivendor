import 'package:flutter/material.dart';
import 'package:multivendor/controllers/auth_controller.dart';
import 'package:multivendor/utils/snackbar.dart';
import 'package:multivendor/views/auth/register_screen.dart';


import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool _obscureText = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  bool _isLoading = false;

  loginUsers()async{
    setState(() {
      _isLoading = true;
    });
    if(_globalKey.currentState!.validate()){
   String res = await _authController.loginUsers(
          email,
          password
      );
        setState(() {
          _isLoading = false;
        });
        if(res == 'success'){
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MainScreen();
          }));
        }else{
          snack(context, res);
        }


    }else{
      setState(() {
        _isLoading = false;
      });
      return snack(context, 'Please Fill All Fields');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _globalKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login Customers Account',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (valid){
                    if(valid!.isEmpty){
                      return 'Please Email Must Not Be Empty';
                    }else{
                      null;
                    }
                  },
                  onChanged: (val){
                    email = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Email'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (valid){
                    if(valid!.isEmpty){
                      return 'Please Password Must Not Be Empty';
                    }else{
                      null;
                    }
                  },
                  obscureText: _obscureText,
                  onChanged: (val){
                    password = val;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon:_obscureText == true ?const Icon(Icons.visibility):
                            const Icon(Icons.visibility_off)
                    ),
                      labelText: 'Enter Password'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    loginUsers();
                  },
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                      ),
                      child:  Center(
                        child: _isLoading ? const CircularProgressIndicator():const Text('Login',
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
                    const Text('Don\'t have an account?',
                      style: TextStyle(
                          fontSize: 20
                      ) ,
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return BuyerRegisterScreen();
                          }));
                        },
                        child:   const Text('Signup',
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
    );
  }
}
