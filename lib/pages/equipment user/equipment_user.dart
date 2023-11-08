import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jonah/pages/equipment%20user/profile.dart';

import '../const/my_drawer.dart';
import '../home.dart';
import 'community.dart';
import 'market.dart';
import 'more.dart';

class EquipmentUser extends StatefulWidget {
  const EquipmentUser({super.key});

  @override
  State<EquipmentUser> createState() => _EquipmentUserState();
}

class _EquipmentUserState extends State<EquipmentUser> {
//sign out
  void SignOutUser() {
    FirebaseAuth.instance.signOut();
  }

  int selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Community(),
    const Market(),
    const Profile(),
    const More(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  //naviagate to profile [page
  void gotoProfilePage() {
    Navigator.pop(context);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Profile();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MedLink',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(
        onProfileTap: gotoProfilePage,
        //  onsignOut: signOut,
      ),
      backgroundColor: Colors.grey.shade200,
      body: _pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GNav(
              rippleColor: Colors.yellow,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.all(10),
              gap: 4,
              onTabChange: navigateBottomBar,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  iconColor: Colors.brown,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.people,
                  iconColor: Colors.brown,
                  text: 'Community',
                ),
                GButton(
                  icon: Icons.shop,
                  iconColor: Colors.brown,
                  text: 'Market',
                ),
                GButton(
                  icon: Icons.person,
                  iconColor: Colors.brown,
                  text: 'User profile',
                ),
                GButton(
                  icon: Icons.more_horiz_outlined,
                  iconColor: Colors.brown,
                  text: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
