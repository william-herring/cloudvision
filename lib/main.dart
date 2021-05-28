import 'screens/camera.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/collections.dart';
import 'package:camera/camera.dart';
import 'screens/cloud-info.dart';

CameraDescription cam;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  cam = firstCamera;

  runApp(CloudvisionApp());
}

void openCamera(context) => Navigator.pushNamed(context, '/camera');

class CloudvisionApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cloudvision",
      initialRoute: '/',

      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black26,
      ),


      routes: {
        '/' : (context) => HomeScreen(),
        '/collections' : (context) => CollectionScreen(),
        '/camera' : (context) => CameraScreen(camera: cam),
      }
    );
  }
}