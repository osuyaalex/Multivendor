import 'package:flutter/material.dart';

snackBar(context, String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),backgroundColor: Colors.black,));
}