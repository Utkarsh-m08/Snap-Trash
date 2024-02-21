import 'dart:convert';
import 'dart:typed_data';

import 'package:SnapTrash/pages/profile.dart';
import 'package:SnapTrash/properties/colourProp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalReports extends StatefulWidget {
  const LocalReports({super.key});

  @override
  State<LocalReports> createState() => _LocalReportsState();
}

class _LocalReportsState extends State<LocalReports> {
  @override
  Widget build(BuildContext context) {
    // size variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: rang6,
      appBar: AppBar(
        elevation: 4,
        // shadowColor: rangBackground,
        backgroundColor: rang6,
        title: Text(
          "Past Reports",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.065,
            color: rangBackground,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profile(),
                ),
              );
            },
            icon: Icon(
              Icons.person_pin,
              color: rang7,
              size: screenWidth * 0.08,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
            //add list builder here
          ReportsHistory()
        ],
      ),
    );
  }
}


class ReportsHistory extends StatefulWidget {
  const ReportsHistory({super.key});

  @override
  State<ReportsHistory> createState() => _ReportsHistoryState();
}

class _ReportsHistoryState extends State<ReportsHistory> {
  late Future<List<DocumentSnapshot>> futureData;

  Future<List<DocumentSnapshot>> fetchData() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('reports').where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
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