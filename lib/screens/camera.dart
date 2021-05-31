import 'package:cloudvision/screens/cloud-info.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'cloud-info.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool _checkMarkTicked = false;

  void initState() {
    super.initState();

    _checkMarkTicked = false;

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget titleText(Color color, String text) {
    return Text(
      text,
      //maxLines: 1,
      style: GoogleFonts.quicksand(textStyle: TextStyle(
        fontSize: 23.0,
        color: color,
        fontWeight: FontWeight.bold,
      )),
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Column(
      children: [
        FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        ),
        Container(
          margin: EdgeInsets.all(20.0),
          
          child: CheckmarkButton(_initializeControllerFuture, _controller),
        ),

        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 10),

          child: Text(
            "Point your device towards the sky.",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ]
      ),
    );
  }
}

class CheckmarkButton extends StatefulWidget {
  var _initControllerFuture;
  var _controller;

  CheckmarkButton(controllerFuture, controller) {
    this._initControllerFuture = controllerFuture;
    this._controller = controller;
  }

  @override
  _CheckmarkButtonState createState() => _CheckmarkButtonState(_initControllerFuture, _controller);
}

class _CheckmarkButtonState extends State<CheckmarkButton> {
  bool isChecked = false;
  var initControllerFuture;
  var controller;

  _CheckmarkButtonState(this.initControllerFuture, this.controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isChecked ? Icons.check_circle : Icons.check_circle_outline),
        iconSize: 80.0,color: isChecked ? Colors.green : Colors.white,
        onPressed: () async {
          try {
            await initControllerFuture;

            final image = await controller.takePicture();
            print(image.path);

            _showAlert(image);
          }

          catch (e) {
            print(e);
          }

          setState(() {
            isChecked = true;
          });
        });
  }

  Future<void> _showAlert(img) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AnalysisPopup(img.path);
      },
    );
  }
}

class AnalysisPopup extends StatefulWidget {
  String path;

  AnalysisPopup(this.path);

  _AnalysisPopupState createState() => _AnalysisPopupState(path);
}

class _AnalysisPopupState extends State<AnalysisPopup> {
  String imagePath;

  _AnalysisPopupState(this.imagePath);

  File image;
  bool isLoading = true;
  List outputs;

  void initState() {
    super.initState();
    loadModel().then((value) {
      classifyImage();
    });

    image = File(imagePath);
  }

  loadModel () async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void classifyImage() async {
    setState(() {
      isLoading = true;
    });

    var output = await Tflite.runModelOnImage(
        path: imagePath,
        numResults: 2,
    );

    print(output);

    setState(() {
      isLoading = false;
      outputs = output;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 180.0),

      child: AlertDialog(
        title: Text("Analysing cloud", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
        content: Column (
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: isLoading ? Text("Please wait...", style: GoogleFonts.quicksand()) : Text("Finished!", style: GoogleFonts.quicksand()),
            ),
            Container(
              child: isLoading ? CircularProgressIndicator(color: Colors.blueGrey) : OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(pageBuilder: (context, animation1, animation2) => CloudInfoScreen(outputs))
                    );
                  },
                  child: Text("See the results", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              ),
              margin: EdgeInsets.all(11.0),
            ),
          ],
        ),
        
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              child: Text("Cancel", style: GoogleFonts.quicksand(color: Colors.blueGrey, fontWeight: FontWeight.w800))
          )
        ],
      ),
    );
  }
}