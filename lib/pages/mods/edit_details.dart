import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditBusRouteScreen extends StatefulWidget {
  final String routeId;

  const EditBusRouteScreen({super.key, required this.routeId});

  @override
  _EditBusRouteScreenState createState() => _EditBusRouteScreenState();
}

class _EditBusRouteScreenState extends State<EditBusRouteScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchRouteDetails();
  }

  void fetchRouteDetails() async {
    final routeDoc = await firestore.collection('user_details').doc(widget.routeId).get();
    final routeData = routeDoc.data() as Map<String, dynamic>;

    nameController.text = routeData['name'];
    detailsController.text = routeData['details'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bus Route'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 20
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(20),
                  borderSide:const BorderSide(
                      color: Colors.black
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:const BorderSide(
                      color: Colors.black
                  ),
                ),
                labelText: 'Name',


              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 20
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(20),
                  borderSide:const BorderSide(
                      color: Colors.black
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:const BorderSide(
                      color: Colors.black
                  ),
                ),
                labelText: 'Details',


              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                final name = nameController.text;
                final details = detailsController.text;

                if (name.isNotEmpty && details.isNotEmpty) {
                  updateBusRoute(widget.routeId, name, details);
                  Navigator.pop(context);
                }


              },
              child: Container(

                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: const Center(
                  child: Text('Update',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void updateBusRoute(String routeId, String name, String details) async {
    await firestore.collection('bus_routes').doc(routeId).update({
      'name': name,
      'details': details,
    });
  }
}
