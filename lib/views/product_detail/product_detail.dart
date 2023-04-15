import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/cart_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;
  const ProductDetailScreen({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageIndex = 0;
  String? _selectedSize;
  String _formattedDay(date){
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        title: Text(widget.productData['ProductName'],
          style: const TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                      imageProvider: NetworkImage(widget.productData['ImageUrlList'][_imageIndex])
                  ),
                ),
                Positioned(
                  bottom: 0,
                    child:SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['ImageUrlList'].length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _imageIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                  ),
                                  height: 60,
                                  child: Image.network(widget.productData['ImageUrlList'][index]),
                                ),
                              ),
                            );
                          }
                      ),
                    )
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
             '\$ ${widget.productData['ProductPrice'].toStringAsFixed(2)}',
              style:  TextStyle(
                fontSize: 22,
                letterSpacing: 8,
                fontWeight: FontWeight.bold,
                color: Colors.yellow.shade500
              ),
            ),
            Text(widget.productData['ProductName'],
              style: const TextStyle(
                  fontSize: 22,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold
              ),
            ),
            ExpansionTile(
                title:
                    const Text('product Description'),
              children: [
                Text(widget.productData['ProductDescription'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 6
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                const Text('This product will be Delivered on',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(_formattedDay(widget.productData['scheduleDate'].toDate()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue
                  ),
                )
              ],
            ),
            ExpansionTile(
                title: const Text('Available Sizes'),
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: _selectedSize ==widget.productData['sizeList'][index]
                              ?Colors.blue:null,
                          child: OutlinedButton(
                              onPressed: (){
                                setState(() {
                                  _selectedSize =widget.productData['sizeList'][index];
                                });
                              },
                              child: Text(widget.productData['sizeList'][index])
                          ),
                        ),
                      );
                      }
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            if(_cartProvider.getCartItem.containsKey(widget.productData['ProductId'])){
              return;
            }else{
              if(_selectedSize != null){
                _cartProvider.addProductToCart(
                    widget.productData['ProductName'],
                    widget.productData['ProductId'],
                    widget.productData['ImageUrlList'],
                    1,
                    widget.productData['ProductQuantity'],
                    widget.productData['ProductPrice'],
                    widget.productData['vendorId'],
                    _selectedSize!,
                    widget.productData['scheduleDate']
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item Successfully added'),
                      backgroundColor: Colors.black,
                    ));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add in a size'),
                      backgroundColor: Colors.black,
                    ));
              }
            }

          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Icon(CupertinoIcons.cart,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem.containsKey(widget.productData['ProductId'])?
                  const Text('In Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ):const Text('Add To Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
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
