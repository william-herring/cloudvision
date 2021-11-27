import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloudvision/main.dart';
import 'article-screen.dart';
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
        body: Row(
          children: [
            bannerBox(Color(0xffff6060), "Learn your clouds: 5 resources for learning nephology", true, () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => ArticleScreen("5 resources for learning nephology", Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Nephology is the study of clouds and their various patterns and formations, as well as the weather they produce."
                            " Here, I share five resources for learning about this interesting branch of science.",
                            style: GoogleFonts.quicksand(fontWeight: FontWeight.w500, fontSize: 17.0),
                        ),
                      ),

                      Padding (
                        padding: EdgeInsets.all(10.0),
                        child: Text("List: ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 30.0)),
                      ),

                      Padding (
                        padding: EdgeInsets.all(10.0),
                        child: Column (
                          children: [
                            InkWell(
                              child: Text("Nephology: The Science of Clouds", style: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 20.0, color: Colors.blue)),
                              onTap: () => launch("https://ysjournal.com/nephology-the-science-of-clouds/"),
                            ),
                            InkWell(
                              child: Text("Cloud names and classifications", style: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 20.0, color: Colors.blue)),
                              onTap: () => launch("https://www.metoffice.gov.uk/weather/learn-about/weather/types-of-weather/clouds/cloud-names-classifications"),
                            ),
                            InkWell(
                              child: Text("Learning Zone: Clouds", style: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 20.0, color: Colors.blue)),
                              onTap: () => launch("https://scied.ucar.edu/learning-zone/clouds"),
                            ),
                            InkWell(
                              child: Text("SciJinks: Types of Clouds", style: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 20.0, color: Colors.blue)),
                              onTap: () => launch("https://scijinks.gov/clouds/"),
                            )
                          ]
                        )
                      ),

                      Padding (
                        padding: EdgeInsets.all(10.0),
                        child: Text("Article by William Herring", style: GoogleFonts.quicksand(fontWeight: FontWeight.w400, fontSize: 12.0)),
                      ),
                    ],
                  )),
              ));
            })
          ],
        )
    );
  }

  Widget bannerBox(Color color, String text, bool isTop, Function onTap) {
    return GestureDetector(
        onTap: onTap,

        child: Container(
          child: titleText(text),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(13.0, 10.0, 0.0, 90.0),
          width: 312.0,
          height: 200.0,
          margin: EdgeInsets.fromLTRB(30.0, isTop ? 80.0 : 20.0, 30.0, 0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  color,
                  Color.fromRGBO(color.red, color.green, color.blue, 0.7),
                ]
            ),

            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: color,
          ),
        ));
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
}