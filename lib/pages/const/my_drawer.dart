import 'package:flutter/material.dart';

import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, this.onProfileTap, this.onsignOut});
  final void Function()? onProfileTap;
  final void Function()? onsignOut;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //header
              const DrawerHeader(child: Icon(Icons.person,
                color: Colors.white,
                size: 64,),
              ),

              //home
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: ()=>Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.home,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),


            ],
          ),


          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyListTile(
              icon: Icons.logout_outlined,
              text: 'L O G  O U T',
              onTap:onsignOut,
            ),
          )

          //profile


          //logout
        ],
      ),
    );
  }
}
