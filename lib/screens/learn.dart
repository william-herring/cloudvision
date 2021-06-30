import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:cloudvision/main.dart';
import 'collections.dart';
import 'home.dart';

class LearnScreen extends StatelessWidget {
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
        currentIndex: 2,

        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        selectedLabelStyle: GoogleFonts.quicksand(),
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

      body: LearnScreenContent(),
    );
  }

  void _navigateTo(int index, context) {
    var navigationScreens = [HomeScreen(), CollectionScreen(), LearnScreen()];

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => navigationScreens[index],
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
}

class LearnScreenContent extends StatefulWidget {
  _LearnScreenContentState createState() => _LearnScreenContentState();
}

class _LearnScreenContentState extends State<LearnScreenContent> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container()
    );
  }
}