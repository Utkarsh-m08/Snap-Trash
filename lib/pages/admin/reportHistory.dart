import 'package:SnapTrash/pages/profile.dart';
import 'package:SnapTrash/properties/colourProp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReportHistory extends StatefulWidget {
  const AdminReportHistory({super.key});

  @override
  State<AdminReportHistory> createState() => _AdminReportHistoryState();
}

class _AdminReportHistoryState extends State<AdminReportHistory> {
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
