import 'package:disdrometer_app/graphic/graphic.dart';
import 'package:disdrometer_app/graphic/showDetail.dart';
import 'package:disdrometer_app/routes/bouncyPageRoute.dart';
import 'package:disdrometer_app/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ShowGraphic extends StatefulWidget {
  @override
  _ShowGraphicState createState() => _ShowGraphicState();
}

class _ShowGraphicState extends State<ShowGraphic> {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 8),
                            Text('Graphic',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.left),
                            DropdownButton(
                              elevation: 2,
                              focusColor: Colors.white,
                              items: [
                                DropdownMenuItem(
                                    child: Text('Rain Info',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left)),
                                DropdownMenuItem(
                                    child: Text('Rainfall',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left)),
                                DropdownMenuItem(
                                    child: Text('Diameter',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left)),
                                DropdownMenuItem(
                                    child: Text('Raindrops',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left)),
                              ],
                              onChanged: (value) {},
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Icon(Icons.arrow_drop_down,
                                    size: SizeConfig.safeBlockHorizontal * 6),
                              ),
                              underline: SizedBox(),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1)
                          ],
                        ),
                      ),
                      Container(
                          height: SizeConfig.blockSizeVertical * 64,
                          padding: EdgeInsets.only(left: 32),
                          child: Swiper(
                            itemCount: graphic.length,
                            itemWidth: SizeConfig.screenWidth - 2 * 64,
                            layout: SwiperLayout.STACK,
                            pagination: SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                    activeColor: Colors.teal,
                                    activeSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                    space: SizeConfig.safeBlockHorizontal * 2)),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      ElasticPageRoute(
                                          widget: ShowDetail(
                                              graphicInfo: graphic[index])));
                                },
                                child: Stack(children: <Widget>[
                                  Column(children: <Widget>[
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            13.5),
                                    Card(
                                        color: Colors.white,
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5.5),
                                                  Text(
                                                    graphic[index].time,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: SizeConfig
                                                                .safeBlockHorizontal *
                                                            11),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          1),
                                                  Text(
                                                      graphic[index]
                                                          .description,
                                                      style: TextStyle(
                                                          color: Colors.black26,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          3.5),
                                                  Row(
                                                    children: <Widget>[
                                                      Text('View detail',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: SizeConfig
                                                                      .safeBlockHorizontal *
                                                                  4.4),
                                                          textAlign:
                                                              TextAlign.left),
                                                      SizedBox(
                                                          width: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              1.5),
                                                      Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                              Colors.grey[600],
                                                          size: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              4.4)
                                                    ],
                                                  )
                                                ])))
                                  ]),
                                  Positioned(
                                      left: SizeConfig.screenWidth / 32,
                                      right: SizeConfig.screenWidth / 32,
                                      child: Image.asset(
                                        graphic[index].icon,
                                        width:
                                            SizeConfig.safeBlockHorizontal * 26,
                                        height:
                                            SizeConfig.safeBlockVertical * 26,
                                      )),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 15, right: 15, bottom: 150),
                                  //   child: Image.asset(graphic[index].icon,
                                  //       height:
                                  //           SizeConfig.blockSizeVertical * 25,
                                  //       width: SizeConfig.blockSizeHorizontal *
                                  //           50),
                                  // )
                                ]),
                              );
                            },
                          ))
                    ]))));
  }
}
