import 'dart:io';
import 'package:flutter/material.dart';

class CloudInfoScreen extends StatefulWidget {
  String imagePath;

  CloudInfoScreen(this.imagePath);

  _CloudInfoScreenState createState() => _CloudInfoScreenState(imagePath);
}

class _CloudInfoScreenState extends State<CloudInfoScreen> {
  String _imagePath;

  _CloudInfoScreenState(this._imagePath);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        actions: [Center(child: Image.file(File(_imagePath)))],
        title: Text("Cloud Info"),
      ),

      body: Column(
        children: [
           Center(
            child: Text("Please wait"),
          ),
        ]
      )
    );
  }
}