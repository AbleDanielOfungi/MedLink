import 'package:flutter/material.dart';
import 'package:jonah/pages/engineer/pages/home_page.dart';
import '../equipment user/community.dart';

class Engineer extends StatefulWidget {
  const Engineer({super.key});

  @override
  State<Engineer> createState() => _EngineerState();
}

class _EngineerState extends State<Engineer> {
  int _selectedIndex = 0;

  List pages =  [
    const HomePage(),
    const Community(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: 13,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green.shade600,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items:  const [
            BottomNavigationBarItem(
                backgroundColor: Colors.brown,
                icon: Icon(Icons.home, size: 30,),
                activeIcon: Icon(Icons.home, color: Colors.brown, size: 30,),
                label: "Home"),
            BottomNavigationBarItem(
                backgroundColor: Colors.brown,
                icon: Icon(Icons.people_outline, size: 30,),
                activeIcon: Icon(Icons.people_outline, color: Colors.brown, size: 30,),
                label: "community"),
          ]),
    // Container(
    //   height: MediaQuery.sizeOf(context).height,
    //   width: MediaQuery.sizeOf(context).height,
    //   decoration: BoxDecoration(
    //     color: Colors.white.withOpacity(0.5),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               SizedBox(
    //                 height: 70,
    //               ),
    //               Text('MedLink',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                 ),),
    //               Text('Traverse our Engineer our Available',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold
    //                 ),),
    //               Text('Contact Those close to you',
    //                 style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 16
    //                 ),),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           SizedBox(
    //             height: 55,
    //             child: TextField(
    //               decoration: InputDecoration(
    //                 enabledBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(40),
    //
    //                 ),
    //                 focusedBorder:  OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(40),
    //                 ),
    //                 suffixIcon: Icon(Icons.search,
    //                 color: Colors.white,),
    //                 hintText: 'Search Engineers by location...',
    //                 fillColor: Colors.grey.shade300,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Stack(
    //             children: [
    //               Container(
    //                 height: 80,
    //                 width: MediaQuery.sizeOf(context).width,
    //               ),
    //               Positioned(
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(100),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 35,
    //                 left: 130,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.5,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 10.0,right: 8,left: 8),
    //                     child: Row(
    //                       children: [
    //                         Text('Mbarara',
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                         ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Uganda',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('27 pl',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 40,
    //                 top: 10,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.7,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.yellow,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Text('Eng',
    //                           style: TextStyle(
    //                             color: Colors.purple,
    //                             fontWeight: FontWeight.bold
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Able',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('Daniel Ofungi',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           //two
    //           Stack(
    //             children: [
    //               Container(
    //                 height: 80,
    //                 width: MediaQuery.sizeOf(context).width,
    //               ),
    //               Positioned(
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(100),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 35,
    //                 left: 130,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.5,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 10.0,right: 8,left: 8),
    //                     child: Row(
    //                       children: [
    //                         Text('Mbarara',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Uganda',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('27 pl',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 40,
    //                 top: 10,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.7,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.yellow,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Text('Eng',
    //                           style: TextStyle(
    //                               color: Colors.purple,
    //                               fontWeight: FontWeight.bold
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Able',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('Daniel Ofungi',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           //three
    //           Stack(
    //             children: [
    //               Container(
    //                 height: 80,
    //                 width: MediaQuery.sizeOf(context).width,
    //               ),
    //               Positioned(
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(100),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 35,
    //                 left: 130,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.5,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 10.0,right: 8,left: 8),
    //                     child: Row(
    //                       children: [
    //                         Text('Mbarara',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Uganda',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('27 pl',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 40,
    //                 top: 10,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.7,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.yellow,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Text('Eng',
    //                           style: TextStyle(
    //                               color: Colors.purple,
    //                               fontWeight: FontWeight.bold
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Able',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('Daniel Ofungi',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           //fourth
    //           Stack(
    //             children: [
    //               Container(
    //                 height: 80,
    //                 width: MediaQuery.sizeOf(context).width,
    //               ),
    //               Positioned(
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(100),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 35,
    //                 left: 130,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.5,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 10.0,right: 8,left: 8),
    //                     child: Row(
    //                       children: [
    //                         Text('Mbarara',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Uganda',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('27 pl',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 40,
    //                 top: 10,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.7,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.yellow,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Text('Eng',
    //                           style: TextStyle(
    //                               color: Colors.purple,
    //                               fontWeight: FontWeight.bold
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Able',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('Daniel Ofungi',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           //fifth
    //           Stack(
    //             children: [
    //               Container(
    //                 height: 80,
    //                 width: MediaQuery.sizeOf(context).width,
    //               ),
    //               Positioned(
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(100),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 35,
    //                 left: 130,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.5,
    //                   decoration: BoxDecoration(
    //                     color: Colors.deepPurple,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 10.0,right: 8,left: 8),
    //                     child: Row(
    //                       children: [
    //                         Text('Mbarara',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Uganda',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('27 pl',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 left: 40,
    //                 top: 10,
    //                 child: Container(
    //                   height: 35,
    //                   width: MediaQuery.sizeOf(context).width*0.7,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Colors.yellow,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Text('Eng',
    //                           style: TextStyle(
    //                               color: Colors.purple,
    //                               fontWeight: FontWeight.bold
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //
    //                         Text('Able',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //                         SizedBox(
    //                           width: 3,
    //                         ),
    //                         Text('Daniel Ofungi',
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                           ),),
    //
    //
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           UserDetailsScreen(userId:userId,),
    //
    //         ],
    //       ),
    //     ),
    //   ),
    //
    //
    // ),
      );
  }
}
