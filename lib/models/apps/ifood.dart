import 'delivery_template.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Ifood extends DeliveryTemplate {
  static const mainUrl     = 'https://marketplace.ifood.com.br/v2/search/'; 
  static const mainChannel = 'IFOOD'; 
  http.Client client = http.Client();

  String latitude;
  String longitude;
  String term;

  Future<Map> fetchRestaurants() async {
    String url = mainUrl + "merchants";
    url += "?latitude=$latitude";
    url += "&longitude=$longitude";
    url += "&channel=$mainChannel";
    url += "&term=$term";
    url += "&merchant_features=DELIVERY&size=100&page=0";
    var jsonResponse = {};

    var response = await client.get(url);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return jsonResponse;
  }

}