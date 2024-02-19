import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SnapTrash/pages/reportPages/report_page.dart';
import 'package:SnapTrash/properties/colourProp.dart';

class locationPromptPage extends StatefulWidget {
  const locationPromptPage({super.key});

  @override
  State<locationPromptPage> createState() => _locationPromptPageState();
}

class _locationPromptPageState extends State<locationPromptPage> {
  late String lat;
  late String long;
  String? locationMessage;
  bool locationLoaded = false;
  bool captionLoaded = false;
  TextEditingController _captionController = TextEditingController();

  // for location to work
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location services are dissabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location Permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'locationpermission denied,  we cannot process request',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }
  Future<void> _loadLocation() async {
  try {
    Position position = await getCurrentLocation();
    setState(() {
      lat = '${position.latitude}';
      long = '${position.longitude}';
      locationMessage = 'Latitude: $lat, Longitude: $long';
      locationLoaded = true;
    });

    ByteData data = await rootBundle.load('assets/img.png');
    List<int> imageBytes = data.buffer.asUint8List();
    String base64Image = base64Encode(imageBytes);


    final dio = Dio();
    final response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=AIzaSyDnC4CPE-xnWeib50n_w5Gi4IgqpRfsxc8',
      data: {
        "contents": [
          {
            "parts": [
              {
                "text": "write a one line caption to report this image to authorities. Don't include any locations or anything you don't know about. Just describe the image.\n"
              },
              {
                "inlineData": {
                  "mimeType": "image/png",
                  "data": base64Image,
                }
              }
            ]
          }
        ],
        "generationConfig": {
          "temperature": 0,
          "topK": 32,
          "topP": 1,
          "maxOutputTokens": 4096,
          "stopSequences": []
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          }
        ]
      },
    );
    print(response.data);
    print(response.data['candidates'][0]['content']['parts'][0]['text']);
    _captionController.text = response.data['candidates'][0]['content']['parts'][0]['text'];
    captionLoaded = true;
  } catch (e) {
    print('Error loading location: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: screenheight * 0.9698,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                height: screenheight,
                width: screenWidth,
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                )
              ),
              Container(
                height: screenheight,
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                      color: rang6,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: screenheight * 0.53,
                        color: rang6,
                        child: Column(
                          children: [
                            TextField(
                              controller: _captionController,
                              maxLines: null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: rang6Light2,
                                hintText: captionLoaded ? 'Add a caption' : 'Generating from Google Gemini...',
                                hintStyle: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: const Color.fromARGB(185, 255, 255, 255),
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 180,
                              width: screenWidth,
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                child: Image.asset(
                                  'assets/images/map_temp.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: screenWidth,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                color: rang6Light,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              ),
                              child: locationLoaded ? Text(
                                locationMessage!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                              : const Center(
                                  child: Text(
                                    'Location...',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                              ) ,
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 33, 72, 243),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Text(
                                    'Dry Waste',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 33, 72, 243),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Text(
                                    'Recyclable',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 33, 72, 243),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Text(
                                    'Burnable',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                  builder: (context) => ReportPage(location: locationMessage!,),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 14, 20, 195),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  'Report',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}


