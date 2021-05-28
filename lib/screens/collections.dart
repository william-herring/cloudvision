import 'package:cloudvision/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'home.dart';

class CollectionScreen extends StatelessWidget {
  final routeNumbers = {
    0 : '/',
    1 : '/collections',
  };

  Widget build(BuildContext context) {
    return Scaffold (
      floatingActionButton: FloatingActionButton (
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Colors.blueGrey,
        onPressed: () => openCamera(context),
      ),

      bottomNavigationBar: BottomNavigationBar (
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        selectedLabelStyle: GoogleFonts.quicksand(),
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_outlined),
            label: "Collections",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Learn",
          )
        ],

        onTap: (i) {
          _navigateTo(i, context);
        },
      ),

      body: CollectionScreenContent(),
    );
  }

  void _navigateTo(int index, context) {
    var navigationScreens = [HomeScreen(), CollectionScreen()];

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => navigationScreens[index],
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
}

class CollectionScreenContent extends StatefulWidget {
  _CollectionScreenContentState createState() => _CollectionScreenContentState();
}

class _CollectionScreenContentState extends State<CollectionScreenContent> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: titleText(Color(0xFF212121), "Nothing here yet."),
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

  Widget bannerBox(Color color, String text, bool isTop) {
    return Container(
      child: titleText(Colors.white, text),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(13.0, 10.0, 0.0, 90.0),
      width: 500.0,
      margin: EdgeInsets.fromLTRB(30.0, isTop ? 80.0 : 20.0, 30.0, 0.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: color,
      ),
    );
  }

  Widget showcaseBox(Color boxColor, String title) {
    return Container(
      child: titleText(Colors.white, title),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 30.0),
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: boxColor,
      ),
    );
  }
}
