import 'package:cloudvision/main.dart';
import 'package:cloudvision/screens/collections.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article"),
      ),
    );
  }
}