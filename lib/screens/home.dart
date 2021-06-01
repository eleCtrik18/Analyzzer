import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animatedbg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF57752),
          brightness: Brightness.dark,
          elevation: 0,
          title: Text('Analyzzer'),
          centerTitle: true,
          actions: [
            // IconButton(
            //   tooltip: 'Settings',
            //   enableFeedback: true,
            //   icon: Icon(
            //     CupertinoIcons.gear_alt_fill,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : AnimatingBg1(Container()));
  }
}
