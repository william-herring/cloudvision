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
