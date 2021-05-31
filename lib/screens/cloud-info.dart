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
  _CloudInfoScreenState(this._modelResults);

  void initState() {
    super.initState();

    print("${_modelResults[0]["confidence"]}");

    _confidence = (num.parse("${_modelResults[0]["confidence"]}") * 100).toStringAsFixed(1);

    print(_modelResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modelResults != null ? "${_modelResults[0]["label"]}" : "Model output is null"),
      ),

      body:
        Center(
            child: Text(_modelResults != null ? _confidence + "% match" : "Model output is null"),
        )
    );
  }
}
