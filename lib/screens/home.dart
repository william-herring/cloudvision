import 'package:cloudvision/screens/learn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:cloudvision/main.dart';
import 'collections.dart';

class HomeScreen extends StatelessWidget {
  final routeNumbers = {
    0 : '/',
    1 : '/collections',
    2 : '/learn'
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
        selectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w800),
        unselectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w800),
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

      body: HomeScreenContent(),
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

class HomeScreenContent extends StatefulWidget {
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildContent()
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        bannerBox(Colors.redAccent, "Saved clouds", true, () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => CollectionScreen(),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        }),
        Row(
            children: [
              showcaseBox(Color(0xFFE0BC57), "10 types of clouds", true),
              showcaseBox(Color(0xFF4FA4CB), "Sample clouds", false),
            ]
        ),
        bannerBox(Color(0xFF9A4D84), "How does this app work?", false, () {}),
      ],
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      //maxLines: 1,
      style: GoogleFonts.quicksand(textStyle: TextStyle(
        fontSize: 23.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      )),
    );
  }

  Widget bannerBox(Color color, String text, bool isTop, Function onTap) {
    return GestureDetector(
        onTap: onTap,

        child: Container(
          child: titleText(text),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(13.0, 10.0, 0.0, 90.0),
          width: 500.0,
          margin: EdgeInsets.fromLTRB(30.0, isTop ? 80.0 : 20.0, 30.0, 0.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: color,
          ),
    ));
  }

  Widget showcaseBox(Color boxColor, String title, bool isLeft) {
    return Container(
      child: titleText(title),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
      width: 150.0,
      height: 150.0,
      margin: EdgeInsets.fromLTRB(isLeft ? 30.0 : 5.0, 20.0, isLeft ? 10.0 : 10.0, 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: boxColor,
      ),
    );
  }
}