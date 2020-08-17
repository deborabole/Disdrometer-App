import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostMethod {
  final String lat, long, status;
  final int curahHujan, diameter, jumlahButir;

  PostMethod(
      {@required this.lat,
      @required this.long,
      @required this.status,
      @required this.curahHujan,
      @required this.diameter,
      @required this.jumlahButir});

  factory PostMethod.fromJson(Map<String, dynamic> object) {
    return PostMethod(
        lat: object['lat'],
        long: object['long'],
        status: object['STATUS'],
        curahHujan: object['curah_hujan'],
        diameter: object['diameter'],
        jumlahButir: object['jumlah_butir']);
  }

  static Future<List<PostMethod>> createPostResult(
      String lat, String long) async {
    final String apiKey =
        'http://103.27.207.134/disdrometerweb/web/api/sensor/get-value-from-lat-long';

    http.Response response = await http.post(apiKey,
        body: {'lat': lat, 'long': long},
        headers: {'app_mobile_token': 'd15dR0M3T3r'});

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      List<PostMethod> result =
          body.map((element) => PostMethod.fromJson(element)).toList();

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
