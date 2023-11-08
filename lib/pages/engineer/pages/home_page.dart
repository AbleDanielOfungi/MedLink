import 'package:flutter/material.dart';
import 'package:jonah/pages/engineer/pages/screens/eng_home.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: EngHome(),
    );
  }
}
