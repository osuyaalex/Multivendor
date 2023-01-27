import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';



import '../../controllers/vendor_controller.dart';
import '../../utils/snackbar.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  late String countryValue;
  late String stateValue;
  late String cityValue;
  final VendorController _controller = VendorController();
  Uint8List? _image;
  final List<String> _taskOptions = ['Yes', 'No'];
   String? taskStatus;
  late String _businessName;
  late String _email;
  late String _phoneNo;
  String? _taxNumber;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  // bool _isLoading = false;

  pickImageFromGallery()async{
    Uint8List im = await _controller.pockStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }
  _saveVendorDetails()async{
    EasyLoading.show(status: 'please wait');
    // setState(() {
    //   _isLoading = true;
    // });
    if(_globalKey.currentState!.validate()){
      if(_image != null){
      String res =  await  _controller.saveVendor(
            _businessName,
            _email,
            _phoneNo,
            countryValue,
            stateValue,
            cityValue,
            taskStatus!,
            _taxNumber,
            _image,
        ).whenComplete((){
          EasyLoading.dismiss();
          setState(() {
            _globalKey.currentState!.reset();
            _image = null;
          });
      });
      EasyLoading.dismiss();
      // setState(() {
      //   _isLoading = false;
      // });
      if(res != 'success'){
        return snackBar(context, res);
      }
      }else{
        EasyLoading.dismiss();
        //_isLoading = false;
        return snackBar(context, 'Select an image');
      }
    }else{
      EasyLoading.dismiss();
      // setState(() {
      //   _isLoading =false;
      // });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 200,
              flexibleSpace: LayoutBuilder(
                  builder: (context, constraints){
                    return FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black,
                            Colors.red
                          ])
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image != null ? Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: MemoryImage(_image!),fit: BoxFit.fill),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                    onPressed: (){
                                      pickImageFromGallery();
                                    },
                                    icon: const Icon(CupertinoIcons.camera)
                                ),
                              ): Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                    onPressed: (){
                                      pickImageFromGallery();
                                    },
                                    icon: const Icon(CupertinoIcons.photo)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (v){
                        setState(() {
                          _businessName = v;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please business name must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Business Name',

                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (v){
                        setState(() {
                          _email = v;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please email must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',

                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (v){
                        setState(() {
                          _phoneNo = v;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please phone number must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Phone no',

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged:(value) {
                          setState(() {
                            cityValue = value;
                          });
                        },

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        const Text('Task Registered ?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: DropdownButtonFormField(
                            hint: const Text('Select'),
                            items: _taskOptions.map<DropdownMenuItem<dynamic>>((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                taskStatus = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    taskStatus == 'Yes' ?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (v){
                          _taxNumber = v;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please Tax number must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Tax Number'
                        ),
                      ),
                    ):Container(),
                    GestureDetector(
                      onTap: (){
                        _saveVendorDetails();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.4,
                        decoration:  BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.red
                              ],
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:  const Center(
                          child: Text('Save',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(onPressed: ()async{
                      await FirebaseAuth.instance.signOut();
                    }, child: Text('data')
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
