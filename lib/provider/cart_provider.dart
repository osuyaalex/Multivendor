import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:multivendor/models/cart_attributes.dart';

class CartProvider with ChangeNotifier{
  Map<String, Cart> _cartItems = {};
  Map<String, Cart> get getCartItem{
    return _cartItems;
  }
  double get totalPrice{
    var total = 0.0;
    _cartItems.forEach((key, value) {
     total += value.price * value.quantity;
    });
    return total;
  }
  addProductToCart(String productName, String productId, List imageUrl, int quantity,int productQuantity, double price, String vendorId, String size, Timestamp scheduleDate){
    if(_cartItems.containsKey(productId)){
      _cartItems.update(productId, (value){
       return Cart(
           productName: value.productName,
           productId: value.productId,
           imageUrl: value.imageUrl,
           quantity: value.quantity + 1,
           productQuantity: value.productQuantity,
           price: value.price,
           vendorId: value.vendorId,
           size: value.size,
           scheduleDate: value.scheduleDate
       );
      });
      notifyListeners();
    }else{
      _cartItems.putIfAbsent(productId, (){
        return Cart(
            productName: productName,
            productId: productId,
            imageUrl: imageUrl,
            quantity: quantity,
            productQuantity: productQuantity,
            price: price,
            vendorId: vendorId,
            size: size,
            scheduleDate: scheduleDate
        );
      }
      );
      notifyListeners();
    }
  }
  void increment(Cart cartAttribute){
    cartAttribute.increase();
    notifyListeners();
  }
  void decrement(Cart cartAttribute){
    cartAttribute.decrease();
    notifyListeners();
  }
  removeItem(productId){
    _cartItems.remove(productId);
    notifyListeners();
  }
  remmoveAllItem(){
    _cartItems.clear();
    notifyListeners();
  }
}