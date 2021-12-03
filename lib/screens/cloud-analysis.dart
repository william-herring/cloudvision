import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloudvision/main.dart';
import 'package:cloudvision/screens/camera.dart';
import 'package:cloudvision/screens/collections.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'cloud-info.dart';
import 'package:geocoding/geocoding.dart';

class CloudAnalysisScreen extends StatefulWidget {
  var modelResults;
  File image;
  CloudAnalysisScreen(this.modelResults, this.image);

  @override
  _CloudAnalysisScreenState createState() => _CloudAnalysisScreenState(modelResults, image);
}

class _CloudAnalysisScreenState extends State<CloudAnalysisScreen> {
  var _modelResults;
  var _confidence;
  CloudData _cloudData;
  File _image;
  var _name;
  _CloudAnalysisScreenState(this._modelResults, this._image);

  void initState() {
    super.initState();

    if (_modelResults == null) {
      return;
    }

    _name = "${_modelResults[0]["label"]}".replaceRange(0, 2, "");
    _confidence = (num.parse("${_modelResults[0]["confidence"]}") * 100).toStringAsFixed(1);

    _cloudData = new CloudData(_name, _image, (num.parse("${_modelResults[0]["confidence"]}") * 100).toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_name, style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(pageBuilder: (context, animation1, animation2) => CameraScreen(camera: cam))
            );
          },
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 230, 8.0, 0.0),

              child: Text("Your cloud was identified as " + getCorrectPronoun(_name) + " " + _name, style:
                GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(
                    0xff6491b5)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 8.0, 0.0),
                child: Text(_confidence + "% match", style:
                  GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 20.0, color: Color(0xff6491b5)),
                  textAlign: TextAlign.center,
                )
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => CloudInfoScreen(_cloudData.getDataMap(), CloudAnalysisScreen(_modelResults, _image)),
                      transitionDuration: Duration(seconds: 0),
                    )
                );
              },
              child: simpleButton("More about this cloud"),
            ),
            GestureDetector(
              onTap: () {
                _cloudData.saveData();
                updatePrefs();

                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => CollectionScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
              child: simpleButton("Add to collection"),
            ),
          ],
        ),
      )
    );
  }

  String getCorrectPronoun(String noun) {
    var vowels = ['A', 'E', 'O', 'I', 'U'];

    if (vowels.contains(noun[0])) {
      return 'an';
    } else return 'a';
  }

  Widget simpleButton(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),

      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Color(0xff6491b5),
      ),

      child: Container(
          child: Text(text, textAlign: TextAlign.center, style:
          GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 15.0, color: Color(
              0xffe3e3e3))
          )
      ),
      padding: EdgeInsets.fromLTRB(70.0, 15.0, 70.0, 15.0),
    );
  }
}

class CloudData {
  String speciesName;
  File image;
  var accuracy;
  var predictionMessage;
  Position _currentPosition;
  String _currentAddress;

  CloudData(this.speciesName, this.image, this.accuracy);

  String getPredictions() {
    var predictions = {
      'Cirrus' : "A condition change will be felt soon.",
      'Cirrostratus' : "Rain will fall within 24 hours.",
      'Cirrocumulus' : "Weather conditions will remain fair, but cool.",
      'Altocumulus' : "Weather conditions will remain fair.",
      'Altostratus' : "Continuous rain will arrive soon. ",
      'Nimbostratus' : "Gloomy conditions with continuous rain can be expected.",
      'Cumulus' : "Weather conditions will remain fair.",
      'Stratus' : "Weather conditions will be fair, but gloomy.",
      'Cumulonimbus' : "Heavy rain and hail is likely.",
      'Stratocumulus' : "Weather conditions will remain fair for some time, but a storm may be coming.",
    };

    return predictions[speciesName];
  }

  String getFacts() {
    var facts = {
      'Cirrus' : "These clouds do not usually appear in a large solid shape, instead they appear in feather-like clouds. Cirrus clouds are mostly made up of ice crystals.",
      'Cirrostratus' : "These clouds blanket the sky in a thin layer of white. These clouds are most often seen during the winter.",
      'Cirrocumulus' : "These clouds are sheet-looking, thin clouds tht have a fabric-like pattern. They look like they are full of small ripples.",
      'Altocumulus' : "These clouds have many layers that cover large parts of the sky in grey or white fluffy ripples. They are made of liquid water but don't usually produce rain.",
      'Altostratus' : "These clouds are grey clouds that cover the sky. They are made up of ice crystals and water droplets. Watch out, these usually mean rain is coming!",
      'Nimbostratus' : "These clouds are grey-white coloured clouds that cover the sky in a thick enough layer to block out the sun from view.",
      'Cumulus' : "These clouds look lie fluffy, white balls floating in the sky. They come in varying sizes and shapes, making them some of the coolest looking clouds.",
      'Stratus' : "These clouds look like thin, white sheets that colver the entire sky. These clouds are very low and you may notice them when driving through mountains.",
      'Cumulonimbus' : "These clouds look like a large grey pile of clouds. They are often formed in hot, moist conditions.",
      'Stratocumulus' : "These clouds are grey, patchy looking clouds that have a honeycomb-like appearance.",
    };

    return facts[speciesName];
  }

  String getTitle() {
    return speciesName;
  }

  String getAccuracy() {
    return accuracy;
  }

  bool checkForExistingData() {
    if (savedCloudData.contains(getDataMap())) {
      return true;
    } else {
      return false;
    }
  }

  void saveData() {
    savedCloudData.add(getDataMap());
    //updatePrefs();
  }

  Map getDataMap() {
    getLocation();
    getAddressFromCoordinates();

    var data = {
      'img' : image.path,
      'title' : speciesName,
      'accuracy' : getAccuracy(),
      'prediction' : getPredictions(),
      'fact' : getFacts(),
      'location' : _currentAddress,
    };

    return data;
  }

  getLocation() async {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      print(position);
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];

      _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }
}
