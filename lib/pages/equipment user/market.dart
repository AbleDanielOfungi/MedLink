import 'package:flutter/material.dart';

import '../../products/popular product/popular products/popular_products.dart';
import '../../products/popular product/upload/product_upload.dart';


class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Market place'),
        backgroundColor: Colors.white,
      ),
      body: const PopularProductListScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const AddPopularProductScreen();

          }));
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
