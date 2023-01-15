import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/views/nav_screens/widgets/banner.dart';
import 'package:multivendor/views/nav_screens/widgets/category_text.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 25, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Text('Howdy, What Are You\n Looking For👀',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: SvgPicture.asset('assets/icons/shopping_cart.svg', height: 20,),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/search.svg', width: 17,),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search for product',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,

            )
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BannerScreen(),
        CategoryText()
      ],
    );
  }
}
