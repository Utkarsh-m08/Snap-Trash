import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SnapTrash/pages/homeScreen.dart';
import 'package:SnapTrash/pages/infoMainPage.dart';
import 'package:SnapTrash/pages/loginSignin/loginPage.dart';
import 'package:SnapTrash/properties/colourProp.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  // variable

  // text controllers
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // size variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    // register
    void register() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const homeScreen(),
            ),
            (e) => false,
          );
        }
      }
    }

    // signout
    // void signUserOut() async {
    //   FirebaseAuth.instance.signOut();
    // }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: rangPrimary,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              rangPrimary,
              rangSecondary,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Align(
                alignment: const Alignment(0, -0.2),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Text(
                      //   "if new",
                      //   style: GoogleFonts.montserrat(
                      //     fontSize: screenWidth / 18,
                      //     // fontWeight: FontWeight.bold,
                      //     color: rang6Light2,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          "Register",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth / 12,
                            fontWeight: FontWeight.bold,
                            color: rang6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 0),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0,
                                color: rangBackground,
                              ),
                            ),
                            fillColor: rangBackground,
                            focusColor: rang6Light2,
                            labelText: "Email",
                            helperText: '',
                            filled: true,
                          ),
                          style: GoogleFonts.montserrat(
                            // fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: rangAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 5,
                          bottom: 20,
                        ),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0,
                                color: rang6Light2,
                              ),
                            ),
                            fillColor: rangBackground,
                            focusColor: rangPrimary,
                            labelText: "Password",
                            helperText: '',
                            filled: true,
                          ),
                          style: GoogleFonts.montserrat(
                            // fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: rangPrimaryLight,
                          ),
                        ),
                      ),
                      Container(
                        height: screenWidth / 7,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.green[900], borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                          onPressed: () {
                            register();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Signup",
                            style: GoogleFonts.montserrat(
                              // fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 15,
                              color: rangBackground,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45, right: 20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account?",
                                style: GoogleFonts.montserrat(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenheight / 40,
                                  color: rang6Light,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const loginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenheight / 35,
                                    color: Colors.green[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
