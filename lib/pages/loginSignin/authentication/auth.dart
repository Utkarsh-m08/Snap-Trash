import 'package:SnapTrash/pages/admin/adminHomePage.dart';
import 'package:SnapTrash/pages/admin/adminNavBar.dart';
import 'package:SnapTrash/pages/loginSignin/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SnapTrash/pages/homeScreen.dart';
import 'package:SnapTrash/pages/infoMainPage.dart';

class auth extends StatelessWidget {
  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // check if user logged in
          if (snapshot.hasData) {
            if (const loginPage().dropdownValue == "User") {
              return const homeScreen();
            } else {
              return const AdminNavBar();
            }
            // Navigator.pop(context);
          }

          // user is not logged in
          else {
            return const infoMainPage();
          }
        },
      ),
    );
  }
}
