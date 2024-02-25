import 'package:SnapTrash/properties/colourProp.dart';
import 'package:flutter/material.dart';

class AdminMap extends StatefulWidget {
  const AdminMap({super.key});

  @override
  State<AdminMap> createState() => _AdminMapState();
}

class _AdminMapState extends State<AdminMap> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: rang6,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Card(
                  color: rang6Light,
                  child: ListTile(
                    title: Text(
                      'Heat Map',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: rangBackground,
                      ),
                    ),
                    subtitle: Image.asset('assets/images/heat_map.jpeg')
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Card(
                  color: rang6Light,
                  child: ListTile(
                    title: Text(
                      'Shortest Path',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: rangBackground,
                      ),
                    ),
                    subtitle: Image.asset('assets/images/shortest_path.jpeg')
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}