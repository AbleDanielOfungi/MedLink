import 'package:flutter/material.dart';

class Supplier extends StatelessWidget {
  const Supplier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Supplier'),
      ),
      body: const Center(
        child: Text('Supplier'),
      ),
    );
  }
}
