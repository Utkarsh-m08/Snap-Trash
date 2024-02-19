import 'package:SnapTrash/main.dart';
import 'package:SnapTrash/pages/cameraScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras = getCamera();


class cameraMain extends StatefulWidget {
  const cameraMain({super.key});

  @override
  State<cameraMain> createState() => _cameraMainState();
}

class _cameraMainState extends State<cameraMain> {
  late CameraController _cameraController;

  Future<void> initCamera({required bool frontCamera}) async {
    _cameraController =
        CameraController(_cameras[(frontCamera) ? 0 : 1], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError(
      (Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (_cameras.isNotEmpty) {
      initCamera(frontCamera: true);
    }
    initCamera(frontCamera: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return cameraScreen(
      cameraController: _cameraController,
      initCamera: initCamera,
    );
  }
}