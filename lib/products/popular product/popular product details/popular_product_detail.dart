import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final String productImageURL;
  final double productPrice;
  final String productQuantity;
  final String productDetails;
  final String productCategory;


  const ProductDetailsScreen({super.key, 
    required this.productName,
    required this.productImageURL,
    required this.productPrice,
    required this.productQuantity,
    required this.productDetails,
    required this.productCategory
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.network(
                widget.productImageURL,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                'Product Name: ${widget.productName}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: Ugx${widget.productPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantity: ${widget.productQuantity}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),

              const Text('Product Details',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Category: ${widget.productCategory}',
                style: const TextStyle(fontSize: 14,
                color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),

              Text(
                ' ${widget.productDetails}',
                style: const TextStyle(fontSize: 16),
              ),


               ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Add to Cart'),
              Icon(Icons.shopping_cart),
            ],
          ),
        ),
      ),
    );
  }
}
