import 'package:flutter/material.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
