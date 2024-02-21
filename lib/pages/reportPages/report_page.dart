import 'package:SnapTrash/pages/homeScreen.dart';
import 'package:SnapTrash/pages/leaderBoard.dart';
import 'package:SnapTrash/pages/localReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SnapTrash/properties/colourProp.dart';

class ReportPage extends StatefulWidget {
  final String location;

  const ReportPage({super.key, required this.location});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Authorities> authorities = [
    Authorities(name: 'Authority 1', distance: '1.2 km away'),
    Authorities(name: 'Authority 2', distance: '2.0 km away'),
    Authorities(name: 'Authority 3', distance: '2.2 km away'),
    Authorities(name: 'Authority 4', distance: '2.2 km away'),
    Authorities(name: 'Authority 5', distance: '3.0 km away'),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: rang6,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Authorities',
                    style: TextStyle(
                      color: rangBackground,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Container(
                    height: screenHeight * 0.14,
                    width: screenWidth * 0.8,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: rang6Light2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Today I reported trash at ${widget.location} via SnapTrash.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.4,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                            ),
                            Text(
                              'X',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.45,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.white,
                            ),
                            Text(
                              'WhatsApp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.45,
                    width: screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03, vertical: 0),
                    decoration: BoxDecoration(
                      color: rang6,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                        itemCount: authorities.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: screenHeight * 0.08,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: screenHeight * 0.0009),
                              decoration: BoxDecoration(
                                  color: rang6Light2,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(index == 0 ? 30 : 0),
                                    bottom: Radius.circular(
                                        index == authorities.length - 1
                                            ? 30
                                            : 0),
                                  )),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                title: Text(
                                  authorities[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      authorities[index].distance,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 3, left: 3),
                                      child: const Icon(
                                        Icons.location_on,
                                        color:
                                            Color.fromARGB(98, 255, 255, 255),
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  SizedBox(
                    height: screenHeight * 0.035,
                  ),
                  InkWell(
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.6,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 72, 243),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const homeScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'Send to authorities',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.send,
                                color: Colors.black,
                                size: screenHeight / 35,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: screenHeight * 0.045, left: screenWidth * 0.05),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: screenHeight / 30,
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class Authorities {
  final String name;
  final String distance;

  Authorities({required this.name, required this.distance});
}
