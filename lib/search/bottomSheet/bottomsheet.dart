import 'dart:ui';
import 'dart:math';
import 'package:disdrometer_app/graphic/showGraphic.dart';
import 'package:disdrometer_app/routes/bouncyPageRoute.dart';
import 'package:flutter/material.dart';
import 'expandedbottomsheet.dart';
import 'header.dart';
import 'info.dart';

const double minHeight = 90;
const double iconStartSize = 30;
const double iconEndSize = 75;
const double iconStartMarginTop = 20;
const double iconEndMarginTop = 80;
const double iconVerticalSpacing = 24;
const double iconHorizontalSpacing = 16;

class ExhibitionBottomSheet extends StatefulWidget {
  @override
  _ExhibitionBottomSheetState createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height * 0.75;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get headerTopMargin =>
      lerp(0, 20 + MediaQuery.of(context).padding.top);

  double get headerFontSize => lerp(16, 32);

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  double get itemBorderRadius => lerp(8, 24);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => lerp(8, 0);

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconVerticalSpacing + iconEndSize)) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconHorizontalSpacing + iconStartSize), 0);

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.teal[50], Colors.teal[100]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 7)]),
              child: Stack(
                children: <Widget>[
                  FAB(),
                  SheetHeader(
                      fontSize: headerFontSize, topMargin: headerTopMargin),
                  for (Event event in info) _buildFullItem(event),
                  for (Event event in info) _buildIcon(event),
                ],
              ),
            ),
            onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
          ),
        );
      },
    );
  }

  Widget _buildIcon(Event event) {
    int index = info.indexOf(event);
    return Positioned(
        height: iconSize,
        width: iconSize,
        top: iconTopMargin(index),
        left: iconLeftMargin(index),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(iconLeftBorderRadius),
            right: Radius.circular(iconRightBorderRadius),
          ),
          child: Image.asset('assets/${event.assetName}',
              fit: BoxFit.cover, alignment: Alignment(lerp(1, 0), 0)),
        ));
  }

  Widget _buildFullItem(Event event) {
    int index = info.indexOf(event);
    return ExpandedBottomSheet(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: _controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      data: event.data,
    );
  }
}

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        bottom: 25,
        child: IconButton(
          iconSize: 28,
          color: Colors.teal[700],
          icon: Icon(Icons.show_chart),
          tooltip: 'Show Graphic',
          onPressed: () {
            Navigator.push(context, BouncyPageRoute(widget: ShowGraphic()));
          },
        ));
  }
}
