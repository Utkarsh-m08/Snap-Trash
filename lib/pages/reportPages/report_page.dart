import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snap_trash/properties/colourProp.dart';

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
    return Scaffold(
      backgroundColor: rang6,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Authorities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  width: 300,
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 170,
                      padding: const EdgeInsets.all(10),
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
                            'Click to Tweet',
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
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 45,
                      width: 180,
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
                            'Share on WhatsApp',
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                    color: rang6,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView.builder(
                    itemCount: authorities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 64,
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: .5),
                        decoration: BoxDecoration(
                          color: rang6Light2,
                          borderRadius: BorderRadius.vertical(
                          top: Radius.circular(index == 0 ? 30 : 0),
                          bottom: Radius.circular(index == authorities.length - 1 ? 30 : 0),
                          )
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                                margin: const EdgeInsets.only(top: 3, left: 3),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(98, 255, 255, 255),
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    }
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    height: 45,
                    width: 220,
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
                        Container(
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
                        Container(
                          height: 50,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 3),
                            child: const Icon(
                              Icons.send,
                              color: Colors.black,
                              size: 20,
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
          IconButton(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 40, left: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
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