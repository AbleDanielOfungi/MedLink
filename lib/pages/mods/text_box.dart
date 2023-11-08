import 'package:flutter/material.dart';

import 'details.dart';
import 'edit_details.dart';


class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.text, required this.sectionName, this.onPressed});
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20,right: 20, top: 20),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          //section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,
                style: const TextStyle(
                    color: Colors.white
                ),),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return UserDetails();
                      }));
                    },
                    child: IconButton(onPressed:onPressed, icon: const Icon(Icons.add_circle_outline,
                        color: Colors.white)),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const EditBusRouteScreen(routeId: '',);
                      }));

                    },
                    child: IconButton(onPressed:onPressed, icon: const Icon(Icons.settings,
                        color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
          Text(text),

          //text

        ],
      ),

    );
  }
}
