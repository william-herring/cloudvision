import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CloudInfoScreen extends StatefulWidget {
  var cloudData;
  var originRoute;

  CloudInfoScreen(this.cloudData, this.originRoute);

  _CloudInfoScreenState createState() => _CloudInfoScreenState(cloudData, originRoute);
}

class _CloudInfoScreenState extends State<CloudInfoScreen> {
  var _cloudData;
  var _originRoute;

  _CloudInfoScreenState(this._cloudData, this._originRoute);

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: simpleButton(
          "Back"
        ),

        onTap: () {
          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => _originRoute));
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.elliptical(30.0, 12.0)),

            child: Image.file(File(_cloudData['img'])),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                    child: titleText(Colors.black, _cloudData["title"])
                ),

                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(_cloudData["fact"], textAlign: TextAlign.center,)
                ),

                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text("Predictions: " + _cloudData["prediction"],)
                ),
              ],
            )
          )
        ],
      )
    );
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

  Widget simpleButton(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),

      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Color(0xff6491b5),
      ),

      child: Container(
          child: Text(text, textAlign: TextAlign.center, style:
          GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(
              0xffe3e3e3))
          )
      ),
      padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
    );
  }
}
