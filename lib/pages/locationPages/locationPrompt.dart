import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SnapTrash/pages/reportPages/report_page.dart';
import 'package:SnapTrash/properties/colourProp.dart';


class LocationPromptPage extends StatefulWidget {
  const LocationPromptPage({super.key, required this.imagePath});
  final String imagePath;
  @override
  State<LocationPromptPage> createState() => _LocationPromptPageState();
}

class _LocationPromptPageState extends State<LocationPromptPage> {
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

      ByteData data = await File(widget.imagePath)
          .readAsBytes()
          .then((value) => ByteData.view(value.buffer));
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
                  "text":
                      "Write a short, one line caption to report this to the authorities. Remember you are not just describing the image but generating a caption for the image so that authorities can understand in less and simple words. Describe the quantity, type and one or two other relevant things related to the trash shown in the image but if the caption is becoming too big, meaning bigger than 10 to 15 words then just describe the type and quantity of trash, but don't keep it too short also atleast you should what kind of trash is this and how much, where the trash is lying or any other relevant thing. Not too short not too big. Around 10 - 15 words. And remember to not refer to this image in the caption, meaning do not write anything like 'The image shows...' or 'in this image...' or something similar. Do not produce any location or anything you don't know about. Keep it in single line only. Also if this does not seem like an image of trash or something similar then just produce: 'This doesn't seem like the image of trash.'. Remember to produce this alt message at all cost if the image doesn't seem anything remotely like trash or litter. Please I cannot emphasise this enough. It is very important. You will be provided with the image of some litter only if it is not that Just produce this alt message.\n"
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
      var responseText = response.data['candidates'][0]['content']['parts'][0]
              ['text']
          .toString();
      _captionController.text = responseText.substring(1);
      captionLoaded = true;
    } catch (e) {
      print('Error loading location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              height: screenHeight,
              child: Stack(
                children: [
                  IconButton(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.045, left: screenWidth * 0.05),
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
                      height: screenHeight * 0.60,
                      color: rang6,
                      child: Column(
                        children: [
                          TextField(
                            controller: _captionController,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: rang6Light2,
                              hintText: captionLoaded
                                  ? 'Add a caption'
                                  : 'Generating from Google Gemini...',
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(185, 255, 255, 255),
                                  fontWeight: FontWeight.w500),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 180,
                            width: screenWidth,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.asset(
                                'assets/images/map_temp.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: rang6Light,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: locationLoaded
                                ? Text(
                                    locationMessage!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )
                                : const Center(
                                    child: Text(
                                      'Location...',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.035,
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  color: rangSecondary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  'Dry Waste',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.035,
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  color: rangSecondary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  'Recyclable',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.035,
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  color: rangSecondary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  'Burnable',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportPage(
                                    location: locationMessage!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: screenHeight * 0.045,
                              width: screenWidth * 0.35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: rangSecondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Text(
                                'Report',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: rangBackground,
                                    fontWeight: FontWeight.w700),
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
    ));
  }
}