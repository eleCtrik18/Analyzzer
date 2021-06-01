import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_ai/services/measurement.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser(
        'https://www.pngjoy.com/pngl/57/1282778_man-walking-full-body-person-transparent-transparent-png.png');
  }

  Future<MeasurementId> fetchUser(String imageURL) async {
    Map data = {
      imageURL:
          'https://www.pngjoy.com/pngl/57/1282778_man-walking-full-body-person-transparent-transparent-png.png',
    };
    setState(() {
      isLoading = true;
    });
    var url;

    url = await http.post(
        Uri.parse(
            "https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement"),
        body: data);
    print(url.body);
    return jsonDecode(url.body['d']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analyzzing"),
        ),
        body: FutureBuilder(
            future: fetchUser(
                "https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Container(
                          height: 250,
                          alignment: Alignment.centerLeft,
                          child: Card(
                            child: Text(snapshot.data[index]['neck']),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  snapshot.data[index]["height"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data[index]["weight"],
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  child: Text(
                                    snapshot.data[index]["chest"],
                                    style: TextStyle(color: Color(0xff868597)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  // Widget getCard(item) {
  //   var neck = item['neck'];

  //   var height = item['height'];
  //   var weight = item['weight'];
  //   var belly = item['belly'];

  //   return Card(
  //     elevation: 1.5,
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: ListTile(
  //         title: Row(
  //           children: <Widget>[
  //             Container(
  //               width: 60,
  //               height: 60,
  //               decoration: BoxDecoration(
  //                 color: Colors.amber,
  //                 borderRadius: BorderRadius.circular(60 / 2),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 20,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 SizedBox(
  //                     width: MediaQuery.of(context).size.width - 140,
  //                     child: Text(
  //                       neck,
  //                       style: TextStyle(fontSize: 17),
  //                     )),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(
  //                   height,
  //                   style: TextStyle(color: Colors.grey),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
