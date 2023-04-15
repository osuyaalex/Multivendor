import 'package:flutter/material.dart';
import 'package:multivendor/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
 bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider provider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Charge Shipping',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 4
            ),
          ),
            value: _chargeShipping,
            onChanged:(v){
              setState(() {
                _chargeShipping = v;
                provider.getFormData(chargeShipping: _chargeShipping);
              });
            }
        ),
        _chargeShipping == true? TextFormField(
          validator: (v){
            if(v!.isEmpty){
              return 'Put in a value';
            }
          },
          onChanged: (value){
            provider.getFormData(productShipping: int.parse(value));
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'shipping Charge'
          ),
        ):Container()
      ],
    );
  }
}
