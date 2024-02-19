import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:SnapTrash/firebase_options.dart';
import 'package:camera/camera.dart';
import 'package:SnapTrash/pages/loginSignin/authentication/auth.dart';

late List<CameraDescription> _cameras;
List<CameraDescription> getCamera() {
  return _cameras;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth(),
    );
  }
}
