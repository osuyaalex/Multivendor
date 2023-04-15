import 'package:flutter/material.dart';
import 'package:multivendor/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AttributeScreen extends StatefulWidget {
  const AttributeScreen({Key? key}) : super(key: key);

  @override
  State<AttributeScreen> createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<AttributeScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _editingController = TextEditingController();
  final List<String> _sizeList = [];
  bool _entered = false;
  bool _saveSize = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider provider = Provider.of<ProductProvider>(context);
    return  SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              validator: (v){
                if(v!.isEmpty){
                  return 'Put in value';
                }
              },
              onChanged: (value){
                provider.getFormData(brandName: value);
              },
              decoration: const InputDecoration(
                labelText: 'brand'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: _editingController,
                      onChanged: (v){
                        setState(() {
                          _entered = true;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Size'
                      ),
                    ),
                  ),
                ),
                _entered == true ?ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: (){
                    setState(() {
                      _sizeList.add(_editingController.text);
                      _editingController.clear();
                    });
                    },
                    child: const Text('Add')
                ):Container()
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _sizeList.length,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _sizeList.removeAt(index);
                        provider.getFormData(sizeList: _sizeList);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_sizeList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                }
            ),
          ),
          _sizeList.isNotEmpty ?ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: (){
              provider.getFormData(sizeList: _sizeList);

              setState(() {
                _saveSize = true;
              });
              },
              child:  _saveSize == true ?
              const Text('Size Saved',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ):const Text('Save Size',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              )
          ):Container()
        ],
      ),
    );
  }
}
