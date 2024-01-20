import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snap_trash/properties/colourProp.dart';

class logout extends StatefulWidget {
  const logout({super.key});

  @override
  State<logout> createState() => _logoutState();
}

class _logoutState extends State<logout> {
  // signout
  void signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rangAccent,
      child: ElevatedButton(
          onPressed: () {
            signUserOut();
          },
          child: const Text("logut")),
    );
  }
}
