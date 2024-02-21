import 'package:SnapTrash/properties/colourProp.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coming Soon", style: TextStyle(color: rangBackground),),
        backgroundColor: rang6Light,
      ),
      backgroundColor: rang6,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.09),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Identifying and reporting potholes",
                style: TextStyle(
                  color: rangBackground,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}