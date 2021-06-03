import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class CloudInfoScreen extends StatefulWidget {
  var modelResults;
  CloudInfoScreen(this.modelResults);

  @override
  _CloudInfoScreenState createState() => _CloudInfoScreenState(modelResults);
}

class _CloudInfoScreenState extends State<CloudInfoScreen> {
  var _modelResults;
  var _confidence;
  var _name;
  _CloudInfoScreenState(this._modelResults);

  void initState() {
    super.initState();

    if (_modelResults == null) {
      print("Error: Model output is null. Returning with uninitialized state");
      return;
    }



    _name = "${_modelResults[0]["label"]}".replaceRange(0, 1, "");
    _confidence = (num.parse("${_modelResults[0]["confidence"]}") * 100).toStringAsFixed(1);

    print(_modelResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),

      body:
        Center(
            child: Text(_confidence + "% match"),
        )
    );
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
