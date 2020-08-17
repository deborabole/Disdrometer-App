import 'package:date_time_format/date_time_format.dart';
import 'package:disdrometer_app/graphic/showGraphic.dart';
import 'package:disdrometer_app/http_service/data.dart';
import 'package:disdrometer_app/routes/bouncyPageRoute.dart';
import 'package:disdrometer_app/sizeConfig.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition;
  var currentAddress;
  String status, rainfall, diameter, raindrops;

  //To get current location coordinate
  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });

      getAddressfromCoordinate();
    }).catchError((e) {
      print(e);
    });
  }

  //To get address from coordinate
  getAddressfromCoordinate() async {
    try {
      List<Placemark> place = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark placemark = place[0];
      setState(() {
        currentAddress = '${placemark.subLocality}';
      });
    } catch (e) {
      print(e);
    }
  }

  Future loadData() async {
    // Data.createData(currentPosition.latitude.toString(),
    //     currentPosition.longitude.toString()).then((data) {
    Data.createData('-6.914744', '107.609810').then((data) {
      setState(() {
        this.status = data[0].status;
        this.rainfall = data[0].curahHujan;
        this.diameter = data[0].diameter;
        this.raindrops = data[0].jumlahButir;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getCurrentLocation();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTime dateTime = DateTime.now();
    String date = DateTimeFormat.format(dateTime,
        format: AmericanDateFormats.dayOfWeekShortWithComma);
    String time = DateTimeFormat.format(dateTime, format: TimeFormats.standard);
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.teal[50],
                  Colors.teal[100],
                ]),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: SizeConfig.safeBlockHorizontal * 9,
                              ),
                              (currentAddress != null)
                                  ? Text(
                                      currentAddress,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  11,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : SizedBox(
                                      width: SizeConfig.safeBlockHorizontal * 7,
                                      height:
                                          SizeConfig.safeBlockHorizontal * 7,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.teal[100]),
                                      ),
                                    ),
                            ]),
                        SizedBox(height: SizeConfig.blockSizeVertical * 0.7),
                        Text(date,
                            style: TextStyle(
                                fontSize:
                                    SizeConfig.safeBlockHorizontal * 5.2)),
                        Text(time,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5.2))
                      ]))),
              Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: SizeConfig.safeBlockVertical * 15,
                        child: FlareActor(
                          'assets/Heavy_rainy_day.flr',
                          animation: 'go',
                          alignment: Alignment.topCenter,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                      status != null
                          ? Text(status,
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 10,
                                fontWeight: FontWeight.bold,
                              ))
                          : SizedBox(
                              width: SizeConfig.safeBlockHorizontal * 8,
                              height: SizeConfig.safeBlockHorizontal * 8,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.teal[100]),
                              )),
                    ],
                  )),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Flexible(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.only(top: 32),
                      width: SizeConfig.blockSizeHorizontal * 85,
                      height: SizeConfig.blockSizeVertical * 38.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.15)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: SizeConfig.blockSizeHorizontal * 32,
                                  height: SizeConfig.blockSizeVertical * 10.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RichText(
                                          text: TextSpan(children: [
                                        WidgetSpan(
                                            child: Image.asset(
                                          'assets/icons8-rainfall-30.png',
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.4,
                                        )),
                                        TextSpan(
                                            text: ' Rainfall',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.4,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                      rainfall != null
                                          ? Text('$rainfall mm/h',
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                  fontWeight: FontWeight.w400))
                                          : SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                              height: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.teal[100]),
                                              ),
                                            ),
                                    ],
                                  )),
                              SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 5.2),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: SizeConfig.blockSizeHorizontal * 32,
                                  height: SizeConfig.blockSizeVertical * 10.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RichText(
                                          text: TextSpan(children: [
                                        WidgetSpan(
                                            child: Image.asset(
                                          'assets/icons8-diameter-32.png',
                                          height:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.4,
                                        )),
                                        TextSpan(
                                            text: ' Diameter',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.4,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                      diameter != null
                                          ? Text('$diameter mm',
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                  fontWeight: FontWeight.w400))
                                          : SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                              height: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.teal[100]),
                                              ),
                                            ),
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 3),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: SizeConfig.blockSizeVertical * 10.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    'assets/icons8-rainmeter-32.png',
                                    height:
                                        SizeConfig.blockSizeHorizontal * 4.4,
                                  )),
                                  TextSpan(
                                      text: ' Raindrops',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.4,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ])),
                                raindrops != null
                                    ? Text(raindrops,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    5,
                                            fontWeight: FontWeight.w400))
                                    : SizedBox(
                                        width:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        height:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.teal[100]),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  BouncyPageRoute(widget: ShowGraphic()));
                            },
                            child: Text('Show Graphic',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.5,
                                    color: Colors.blueGrey,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}
