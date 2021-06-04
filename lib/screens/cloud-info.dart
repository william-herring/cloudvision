import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CloudInfoScreen extends StatefulWidget {
  var modelResults;
  File image;
  CloudInfoScreen(this.modelResults, this.image);

  @override
  _CloudInfoScreenState createState() => _CloudInfoScreenState(modelResults, image);
}

class _CloudInfoScreenState extends State<CloudInfoScreen> {
  var _modelResults;
  var _confidence;
  File _image;
  var _name;
  _CloudInfoScreenState(this._modelResults, this._image);

  void initState() {
    super.initState();

    if (_modelResults == null) {
      print("Error: Model output is null. Returning with uninitialized state");
      return;
    }



    _name = "${_modelResults[0]["label"]}".replaceRange(0, 2, "");
    _confidence = (num.parse("${_modelResults[0]["confidence"]}") * 100).toStringAsFixed(1);

    print(_modelResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe0e0e0),

      appBar: AppBar(
        title: Text(_name),
      ),

      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 290, 8.0, 0.0),

              child: Text("Your cloud was identified as " + getCorrectPronoun(_name) + " " + _name, style:
                GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 8.0, 0.0),
                child: Text(_confidence + "% match", style:
                  GoogleFonts.quicksand(fontWeight: FontWeight.normal, fontSize: 20.0),
                  textAlign: TextAlign.center,
                )
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
}

class CloudData {
  String speciesName;
  var predictionMessage;

  CloudData(this.speciesName);

  String _getPredictions() {
    var predictions = {
      'Cirrus' : "A condition change will be felt soon.",
      'Cirrostratus' : "Rain will fall within 24 hours.",
      'Cirrocumulus' : "Weather conditions will remain fair, but cool",
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
}
