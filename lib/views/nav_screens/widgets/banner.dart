import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImage = [];

  getBanners(){
    _firestore.collection('banners').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          _bannerImage.add(element['image']);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PageView.builder(
          itemCount: _bannerImage.length,
            itemBuilder: (context, index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
                child: Image.network(_bannerImage[index], fit: BoxFit.cover,)
            );
            }
        )
      ),
    );
  }
}
