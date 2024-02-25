import 'dart:convert';

import 'package:SnapTrash/properties/colourProp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewReports extends StatefulWidget {
  const NewReports({super.key});

  @override
  State<NewReports> createState() => _NewReportsState();
}

class _NewReportsState extends State<NewReports> {
  late Future<List<DocumentSnapshot>> futureData;

  Future<List<DocumentSnapshot>> fetchData() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('reports').where('status', isEqualTo: 0).get();
  return querySnapshot.docs;
}

  Future<void> updateStatus(DocumentSnapshot document) async {
    await document.reference.update({'status': 1});
  }

  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<DocumentSnapshot>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: screenHeight * 0.77,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(rangBackground),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var document = snapshot.data![index];
                String image = snapshot.data![index]['image'];
                String caption = snapshot.data![index]['caption'];
                String location = snapshot.data![index]['location'];
                String user = FirebaseAuth.instance.currentUser!.email!;
                return Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: Card(
                    color: rang6Light,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User: $user',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: rangBackground,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                          Text(
                            'Location: $location',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: rangBackground,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          Base64ImageWidget(base64String: image),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            caption,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: screenWidth * 0.05,
                              color: rangBackground,
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            alignment: Alignment.center,
                            // color: Colors.red,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: rangPrimary,
                              ),
                              onPressed: () {
                                updateStatus(document);
                                setState(() {
                                  futureData = fetchData();
                                });
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.05,
                                  color: rang6,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  Base64ImageWidget({required this.base64String});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.memory(bytes)
    );
  }
}