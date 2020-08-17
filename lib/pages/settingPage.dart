import 'dart:async';
import 'package:disdrometer_app/search/bottomSheet/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const googleAPIkey = 'AIzaSyBGWv1kaSWz3D-pj2xCjGklQsi1lxDf0kY';

class SettingPage extends StatefulWidget {
  SettingPage() : super();

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(-6.9044158, 107.6561438);
  final Set<Marker> _marker = {};
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _center, zoom: 16.0),
                    onMapCreated: _onMapCreated,
                    markers: _marker,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapType: MapType.normal,
                    onCameraMove: _onCameraMove),
              ),
              ExhibitionBottomSheet()
            ],
          ),
        ),
      ),
    );
  }
}
