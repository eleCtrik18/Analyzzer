import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_ai/screens/display_data.dart';
import 'package:image_ai/services/measurement.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../services/crud.dart';

class AnimatingBg1 extends StatefulWidget {
  AnimatingBg1(Container container);

  @override
  _AnimatingBg1State createState() => _AnimatingBg1State();
}

class _AnimatingBg1State extends State<AnimatingBg1>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  late File selectedImage;
  final _picker = ImagePicker();

  Future getImage() async {
    var pickedImage = await _picker.getImage(source: ImageSource.camera);
    var local = pickedImage;
    if (local != null) {
      setState(() {
        selectedImage = File(pickedImage!.path);
      });

      if (selectedImage != null) {
        setState(() {
          final snackBar = SnackBar(content: Text('Image Uploaded'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _isLoading = true;
        });
      } else {
        print('error');
      }
      final Reference reference = FirebaseStorage.instance
          .ref()
          .child("capturedImage")
          .child("${randomAlphaNumeric(9)}.jpg");
      await reference.putFile(selectedImage);
      var durl = await reference.getDownloadURL();
      print("This is $durl");
    }
  }

  bool isTapped = false;
  List<Color> colorList = [
    Color(0xff171B70),
    Color(0xff410D75),
    Color(0xff032340),
    Color(0xff050340),
    Color(0xff2C0340),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = Color(0xff092646);
  Color topColor = Color(0xff410D75);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = Color(0xff33267C);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: Center(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHighlightChanged: (value) {
            setState(() {
              isTapped = value;
            });
          },
          onTap: () {
            // getImage();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => IndexPage()));
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.fastLinearToSlowEaseIn,
            height: isTapped ? 55 : 60,
            width: isTapped ? 150 : 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30,
                  offset: Offset(3, 7),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Open Camera',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      ),
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
    );
  }
}
