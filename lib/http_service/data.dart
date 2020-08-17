import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Data {
  final String lat, long, status, curahHujan, diameter, jumlahButir;

  Data(
      {@required this.lat,
      @required this.long,
      @required this.status,
      @required this.curahHujan,
      @required this.diameter,
      @required this.jumlahButir});

  factory Data.fromJSON(Map<String, dynamic> object) {
    return Data(
        lat: object['lat'],
        long: object['long'],
        status: object['STATUS'],
        curahHujan: object['curah_hujan'].toString(),
        diameter: object['diameter'].toString(),
        jumlahButir: object['jumlah_butir'].toString());
  }

  static Future<List<Data>> createData(String lat, String long) async {
    final String apiKey =
        'http://103.27.207.134/disdrometerweb/web/api/sensor/get-value-from-lat-long';

    try {
      http.Response response = await http.post(apiKey,
          body: {'lat': lat, 'long': long},
          headers: {'app_mobile_token': 'd15dR0M3T3r'});

      if (response.statusCode == 200) {
        List<Data> list = parsedData(response.body);
        return list;
      } else {
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Data> parsedData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Data>((object) => Data.fromJSON(object)).toList();
  }
}
