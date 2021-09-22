import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey = '020B5A31-E2E3-4DC5-86DB-456934B793E7';
const coinApiUrl = 'https://rest.coinapi.io';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    String url;
    http.Response response;
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      url = '$coinApiUrl/v1/exchangerate/$crypto/$currency?apikey=$apiKey';
      response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double lastPrice = data['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
