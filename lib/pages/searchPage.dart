import 'dart:ui';
import 'package:disdrometer_app/search/searchBar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Search(
                onChange: (value) {
                  print(value);
                },
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.white,
                    Colors.teal[50],
                    Colors.teal[100],
                  ])),
              child: Column(
                children: <Widget>[
                  Flexible(
                      flex: 2,
                      child: FlareActor(
                        'assets/maps.flr',
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        animation: 'anim',
                      )),
                  Flexible(
                      child: Text(
                          'Find rainfall information of another places here.',
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 15))),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            )));
  }
}
