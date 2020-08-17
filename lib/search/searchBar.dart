import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

const googleAPIkey = 'AIzaSyBGWv1kaSWz3D-pj2xCjGklQsi1lxDf0kY';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleAPIkey);

class Search extends StatelessWidget {
  final ValueChanged<String> onChange;

  Search({this.onChange}) : super();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(hintColor: Colors.transparent),
        child: Container(
            height: 42,
            child: TextField(
              onChanged: onChange,
              onTap: () async {
                Prediction prediction = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: googleAPIkey,
                  mode: Mode.overlay,
                );
                displayPrediction(prediction);
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  focusColor: Colors.grey,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  fillColor: Colors.grey[200],
                  filled: true),
            )));
  }

  Future<Null> displayPrediction(Prediction prediction) async {
    if (prediction != null) {
      PlacesDetailsResponse detailsResponse =
          await _places.getDetailsByPlaceId(prediction.placeId);

      var placeId = prediction.placeId;
      double lat = detailsResponse.result.geometry.location.lat;
      double lng = detailsResponse.result.geometry.location.lng;

      var address =
          await Geocoder.local.findAddressesFromQuery(prediction.description);

      print(lat);
      print(lng);
      print(placeId);
      print(address);
    }
  }
}
