import 'package:disdrometer_app/graphic/graphic.dart';
import 'package:flutter/material.dart';

class ShowDetail extends StatelessWidget {
  final GraphicInfo graphicInfo;

  const ShowDetail({Key key, this.graphicInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.white,
              Colors.teal[50],
              Colors.teal[100],
            ])),
        child: ListView.builder(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 2),
          itemCount: graphicInfo.graphicImages.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(12),
              child: Image.asset(graphicInfo.graphicImages[index]),
            );
          },
        ),
      )),
    );
  }
}
