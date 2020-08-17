import 'package:disdrometer_app/sizeConfig.dart';
import 'package:flutter/material.dart';

class ExpandedBottomSheet extends StatelessWidget {
  final double topMargin, leftMargin, height, borderRadius;
  final String data;
  final bool isVisible;

  const ExpandedBottomSheet(
      {Key key,
      this.topMargin,
      this.leftMargin,
      this.height,
      this.borderRadius,
      this.data,
      this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: SizeConfig.blockSizeVertical * 13.5,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 50),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Text(
        data,
        style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 6.5,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
