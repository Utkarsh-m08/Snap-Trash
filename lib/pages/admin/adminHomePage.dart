import 'package:SnapTrash/properties/colourProp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
          "New Reports",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.065,
            color: rangBackground,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            "",
            style: GoogleFonts.sourceCodePro(
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * 0.12,
              color: rangBackground,
            ),
            //add list builder here 
          ),
        ],
      ),
    );
  }
}
