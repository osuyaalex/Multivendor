import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
   CategoryText({Key? key}) : super(key: key);
  final List<String> _category = [
    'Veges', 'Eggs', 'Tea'
  ];

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children:  [
          const Text('Categories',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _category.length,
                        itemBuilder: (context, index){
                          return ActionChip(
                            onPressed: (){},
                            backgroundColor: Colors.black,
                              label: Text(_category[index],
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              )
                          );
                        }
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_forward_ios)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
