import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snap_trash/properties/colourProp.dart';

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
    } catch (e) {
      print('Error loading location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    TextEditingController _captionController = TextEditingController();
    _captionController.text = 'Overflowing dumpster posing health hazards';

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: screenheight,
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
              Column(
                children: [
                  IconButton(
                    padding: EdgeInsets.only(top: screenheight * 0.01, right: screenWidth * 0.8),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    color: rang6,
                  ),
                  SizedBox(
                    height: screenheight * 0.48,
                  ),
                  Container(
                    height: screenheight * 0.4293,
                    color: rang6,
                    child: Column(
                      children: [
                        TextField(
                          controller: _captionController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: rang6Light2,
                            hintText: 'Add a caption',
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 25,
                              color: const Color.fromARGB(185, 255, 255, 255),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18.5,
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
                              'assets/images/map_temp.png',
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
                          child: Text(
                            locationMessage!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
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
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}


