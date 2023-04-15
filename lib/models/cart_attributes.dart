import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier{
  String productName;
  String productId;
  List imageUrl;
  int quantity;
  int productQuantity;
  double price;
  String vendorId;
  String size;
  Timestamp scheduleDate;

  Cart(
      {required this.productName,
        required this.productId,
        required this.imageUrl,
        required this.quantity,
        required this.productQuantity,
        required this.price,
        required this.vendorId,
        required this.size,
        required this.scheduleDate
      }
      );

  void increase(){
    quantity ++;
  }
  void decrease(){
    quantity --;
  }
}
