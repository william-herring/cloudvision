import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatefulWidget {
  String title;
  Widget body;

  ArticleScreen(this.title, this.body);

  @override
  _ArticleScreenState createState() => _ArticleScreenState(title, body);
}

class _ArticleScreenState extends State<ArticleScreen> {
  String _title;
  Widget _body;

  _ArticleScreenState(this._title, this._body);

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(_title, style: GoogleFonts.quicksand(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black)),
      ),

      body: _body,
    );
  }
}