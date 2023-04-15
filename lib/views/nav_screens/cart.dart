import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/cart_provider.dart';
import 'package:multivendor/views/nav_screens/inner%20screens/checkout_screen.dart';
import 'package:provider/provider.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('Cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 5,
                color: Colors.white
              ),
            ),
          ],
        ),
        actions: [IconButton(
            onPressed: (){
              cartProvider.remmoveAllItem();
            },
            icon: Icon(Icons.delete)
        )
        ],
        backgroundColor: Colors.black,
      ),
       body: Provider.of<CartProvider>(context, listen: false).getCartItem.isNotEmpty?ListView.builder(
         itemCount: cartProvider.getCartItem.length ,
           itemBuilder: (context, index){
           final cartData = cartProvider.getCartItem.values.toList()[index];
           return Card(
             child: SizedBox(
               height: 170,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(cartData.imageUrl[0]),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartData.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 3
                          ),
                        ),
                        Text('\$${cartData.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 3,
                            color: Colors.orange
                          ),
                        ),
                        OutlinedButton(
                            onPressed: null,
                            child: Text(cartData.size)
                        ),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade900,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed:cartData.quantity == 1?null: (){
                                        cartProvider.decrement(cartData);
                                      },
                                      icon: const Icon(CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                  ),
                                  Text(cartData.quantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                  IconButton(
                                    onPressed:cartData.quantity == cartData.productQuantity?null: (){
                                      cartProvider.increment(cartData);
                                    },
                                    icon: const Icon(CupertinoIcons.plus,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  cartProvider.removeItem(cartData.productId);
                                },
                                icon: Icon(Icons.remove_shopping_cart_outlined)
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
             ),
           );
           }
       ):

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your shopping cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Text('Continue shopping',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white
                    ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: (){
         if(Provider.of<CartProvider>(context, listen:  false).getCartItem.isNotEmpty){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return const CheckOutScreen();
           }));
         }else{
           return;
         }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          color: Colors.black,
          child:  Center(
            child: Text('\$${cartProvider.totalPrice.toStringAsFixed(2)} Checkout',
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
          ),
        ),
      ),
    );
  }
}
