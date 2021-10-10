import 'package:cloudvision/screens/learn.dart';

import 'screens/camera.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/collections.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'screens/cloud-analysis.dart';
import 'package:shared_preferences/shared_preferences.dart';

CameraDescription cam;
var savedCloudData = [];
var prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  cam = firstCamera;

  prefs = await SharedPreferences.getInstance();
  setCloudData();

  //savedCloudData = [];
  runApp(CloudvisionApp());
}

void updatePrefs() {
  List<String> arr = [];

  for (var d in savedCloudData) {
    List<String> saveData = [
      d['img'].toString(),
      d['title'].toString(),
      d['accuracy'].toString(),
      d['prediction'].toString(),
      d['fact'].toString(),
    ];

    String s = "";
    for (var i in saveData) {
      s += i + "~";
    }

    arr.add(s);
  }

  print(arr);

  prefs.setStringList("savedClouds", arr);
}

void setCloudData() {
  var arr = prefs.getStringList("savedClouds");

  if (arr == null) {
    savedCloudData = savedCloudData;
    return;
  }

  for (var i in arr) {
    var sl = i.split("~");

    var data = {
      'img' : sl[0],
      'title' : sl[1],
      'accuracy' : sl[2],
      'prediction' : sl[3],
      'fact' : sl[4]
    };

    print(data);

    savedCloudData.add(data);
  }
}

void openCamera(context) => Navigator.pushNamed(context, '/camera');

class CloudvisionApp extends StatelessWidget {
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: "Cloudvision",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black26,
      ),


      routes: {
        '/' : (context) => HomeScreen(),
        '/collections' : (context) => CollectionScreen(),
        '/camera' : (context) => CameraScreen(camera: cam),
        '/learn' : (context) => LearnScreen(),
      }
    );
  }
}