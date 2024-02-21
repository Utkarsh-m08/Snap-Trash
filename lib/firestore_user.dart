import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  User? user = FirebaseAuth.instance.currentUser;
  void addData(String image, String caption, String location) {
    CollectionReference reports = FirebaseFirestore.instance.collection('reports');
    reports.add({
      'image': image,
      'caption': caption,
      'location': location,
      'user': user!.uid,
      'status': 0,
    }).then((_) => print('Added to Firestore')
      ).catchError((error) => print('Error adding data: $error')
    );
  }
}