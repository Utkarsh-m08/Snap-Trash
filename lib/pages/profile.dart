import 'package:SnapTrash/properties/colourProp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class profile extends StatefulWidget {
  const profile({super.key});
  // signout

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    // signout
    void signUserOut() async {
      FirebaseAuth.instance.signOut();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => infoPage(),
      //   ),
      // );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: rang6,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenheight * 0.02,
              // left: screenWidth * 0.02,
              // right: screenWidth * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: screenWidth * 0.4,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    color: rang7,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    height: screenWidth * 0.5,
                    width: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      color: rang6,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(30),
                      // ),
                    ),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.email!,
                                style: GoogleFonts.montserrat(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.07,
                                  color: rangBackground,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mobile:",
                                style: GoogleFonts.montserrat(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rang7,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email: " + user.email!,
                                style: GoogleFonts.montserrat(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rang7,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Address: ",
                                style: GoogleFonts.montserrat(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rang7,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: screenWidth * 0.03,
          //     right: screenWidth * 0.03,
          //     bottom: screenheight * 0.03,
          //   ),
          //   child: ElevatedButton.icon(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.edit,
          //       color: rang7,
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: rang6,
          //       foregroundColor: rang6,
          //       // shape: RoundedRectangleBorder(
          //       //   borderRadius: BorderRadius.circular(20),
          //       // ),
          //       elevation: 5,
          //     ),
          //     label: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         "  edit account details",
          //         style:  GoogleFonts.montserrat(
          //           // fontWeight: FontWeight.bold,
          //           fontSize: screenWidth * 0.05,
          //           color: rang7,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(
              top: screenheight * 0.08,
              bottom: screenheight * 0.02,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: Container(
              height: screenheight * 0.01,
              width: screenWidth * 0.4,
              color: rang7,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.history,
                  color: rang6,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rang7,
                  foregroundColor: rang7,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  // signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "History",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rang6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rang6,
            ),
          ),

          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.translate_outlined,
                  color: rang6,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rang7,
                  foregroundColor: rangPrimary,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  // signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   language",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rang6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rang6,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.login_outlined,
                  color: rang6,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rang7,
                  foregroundColor: rangPrimary,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  signUserOut();
                  Navigator.pop(context);
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   Signout",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rang6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rang6,
            ),
          ),
        ],
      ),
    );
  }
}
