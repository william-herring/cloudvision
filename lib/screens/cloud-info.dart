import 'dart:io';
import 'package:flutter/material.dart';

class CloudInfoScreen extends StatefulWidget {
  var modelResults;
  CloudInfoScreen(this.modelResults);

  @override
  _CloudInfoScreenState createState() => _CloudInfoScreenState(modelResults);
}

class _CloudInfoScreenState extends State<CloudInfoScreen> {
  var _modelResults;
  _CloudInfoScreenState(this._modelResults);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
