import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://randomuser.me/api/?results=50";
  List data;
  bool isLoading = false;

  Future getData() async {
    var request = await http.get(
      Uri.encodeFull(url)
    );

    List ConvertDataToJson = jsonDecode(request.body)['results'];
    setState(() {
      data = ConvertDataToJson;
    });
  }

  @override
  void initState(){
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Random User", style: TextStyle(
          color: Colors.white, 
        ),),
      ),
      body: Container(
        child: Center(
          child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, i){
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Image(
                        image: NetworkImage(data[i]['picture']['thumbnail']),
                        width: 100.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              data[i]['name']['first'] + "   " + data[i]['name']['last'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                fontFamily: 'Amatic',
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone_iphone),
                            title: Text(
                              data[i]['phone']
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.person_pin),
                            title: Text(
                              (data[i]['dob']['age'].toString())
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.mail),
                            title: Text(
                              data[i]['email'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                fontFamily: 'Exo2',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ), 
        ),
      ),
    );
  }
}