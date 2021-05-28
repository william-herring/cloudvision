import 'package:image/image.dart';
import 'dart:io';

void main() => analyseImage('/Users/herring/Desktop/cloudvision/test-image.png');

void analyseImage(String imagePath) {
  Image image = decodeJpg(File(imagePath).readAsBytesSync());

  print(image);
}