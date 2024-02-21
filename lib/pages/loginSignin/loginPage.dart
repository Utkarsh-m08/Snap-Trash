import 'package:SnapTrash/pages/loginSignin/signupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SnapTrash/pages/homeScreen.dart';
import 'package:SnapTrash/properties/colourProp.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  get dropdownValue => _dropdownValue;

  @override
  State<loginPage> createState() => loginPageState();
}

const List<String> list = <String>["User", "Admin"];

String _dropdownValue = list.first;

class loginPageState extends State<loginPage> {
  // String _dropdownValue = list.first;
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
    void login() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const homeScreen(),
            ),
          );
        }
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: rangSecondary,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          "Login here!",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth / 12,
                            fontWeight: FontWeight.bold,
                            color: rang6,
                          ),
                        ),
                      ),
                      // drop down for admin
                      DropdownButton<String>(
                        value: _dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                          color: rang6,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 40,
                          bottom: 0,
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0,
                                color: rang6,
                              ),
                            ),
                            fillColor: rangBackground,
                            focusColor: rang7,
                            labelText: "Email",
                            helperText: '',
                            filled: true,
                          ),
                          style: GoogleFonts.montserrat(
                            // fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: rang6,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0,
                                color: rang6,
                              ),
                            ),
                            fillColor: rangBackground,
                            focusColor: rang7,
                            labelText: "Password",
                            helperText: '',
                            filled: true,
                          ),
                          style: GoogleFonts.montserrat(
                            // fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 20,
                            color: rangSecondary,
                          ),
                        ),
                      ),
                      Container(
                        height: screenWidth / 7,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                          onPressed: () {
                            login();
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const homeScreen(),
                            //   ),
                            // );
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              // fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 15,
                              color: rangBackground,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Account?",
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
                                      builder: (context) => const signupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign up",
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
