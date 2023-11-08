import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class EngineerListScreen extends StatefulWidget {
  const EngineerListScreen({super.key});

  @override
  _EngineerListScreenState createState() => _EngineerListScreenState();
}

class _EngineerListScreenState extends State<EngineerListScreen> {
  final CollectionReference _engineerCollection =
      FirebaseFirestore.instance.collection('EngProfile');

  List<DocumentSnapshot> _engineerDocs = [];

  @override
  void initState() {
    super.initState();
    _loadEngineers();
  }

  void _loadEngineers() async {
    final engineers = await _engineerCollection.get();
    setState(() {
      _engineerDocs = engineers.docs;
    });
  }

  void _filterEngineers(String query) {
    final filteredEngineers = _engineerDocs.where((engineer) {
      final engineerData = engineer.data() as Map<String, dynamic>;
      final name = engineerData['name'] ?? '';
      final location = engineerData['location'] ?? '';
      final gender = engineerData['gender'] ?? '';
      final occupation = engineerData['occupation'] ?? '';
      final contact = engineerData['contact'] ?? '';
      final experience = engineerData['experience'] ?? '';

      return name.toLowerCase().contains(query.toLowerCase()) ||
          location.toLowerCase().contains(query.toLowerCase()) ||
          gender.toLowerCase().contains(query.toLowerCase()) ||
          occupation.toLowerCase().contains(query.toLowerCase()) ||
          experience.toString().contains(query);
    }).toList();

    setState(() {
      _engineerDocs = filteredEngineers;
    });
  }

  void _callEngineer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle when the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Could not launch the phone app.'),
      ));
    }
  }

  void _textEngineer(String phoneNumber) async {
    final url = 'sms:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle when the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Could not launch the messaging app.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineer List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: _filterEngineers,
              decoration: const InputDecoration(
                labelText:
                    'Search by name, location, gender, occupation, or experience',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _engineerDocs.length,
              itemBuilder: (context, index) {
                final engineerData =
                    _engineerDocs[index].data() as Map<String, dynamic>;
                final name = engineerData['name'] ?? '';
                final location = engineerData['location'] ?? '';
                final gender = engineerData['gender'] ?? '';
                final occupation = engineerData['occupation'] ?? '';
                final contact = engineerData['contact'] ?? '';
                final experience = engineerData['experience'] ?? '';

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                    ),
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: $location'),
                        Text('Gender: $gender'),
                        Text('Occupation: $occupation'),
                        Text('Contact: $contact'),
                        Text('Experience: $experience years'),
                        Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.green,
                              )),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.call),
                                onPressed: () => _callEngineer(contact),
                              ),
                              IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () => _textEngineer(contact),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
