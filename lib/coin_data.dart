import 'package:http/http.dart' as http;
import 'dart:convert';

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

const kApikey = '7F66F50F-0BF0-4312-9C22-004086A23B6F';
const kUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  double exchangeRate;
  Future<double> getNetworkInfo(String curCur) async {
    var url = http.get('${kUrl}BTC/$curCur?apikey=$kApikey');
    http.Response response = await url;
    if (response.statusCode == 200) {
      exchangeRate = jsonDecode(response.body)['rate'];
    } else {
      print(response.statusCode);
      throw ('not possible to proceed');
    }
    return exchangeRate;
  }
}
