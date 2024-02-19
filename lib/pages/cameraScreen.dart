import 'package:SnapTrash/main.dart';
import 'package:SnapTrash/pages/locationPages/locationPrompt.dart';
import 'package:SnapTrash/properties/colourProp.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraMain extends StatefulWidget {
  const CameraMain({super.key});

  @override
  State<CameraMain> createState() => _CameraMainState();
}

class _CameraMainState extends State<CameraMain> {
  final CameraDescription camera = getCamera().first;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(_controller),
                  Positioned(
                    top: screenHeight * 0.73,
                    left: screenWidth * .5 - screenHeight * 0.15 / 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller.takePicture();
              
                          if (!context.mounted) return;
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LocationPromptPage(
                                imagePath: image.path,
                              ),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Icon(
                      Icons.circle_outlined,
                      size: screenHeight * 0.1,
                      color: rang6,
                    ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      
    );
  }
}