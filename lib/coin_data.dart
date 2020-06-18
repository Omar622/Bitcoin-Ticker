import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'USD',
  'AUD',
  'BRL',
  'CAD',
  'CHF',
  'CLP',
  'CNY',
  'DKK',
  'HKD',
  'GBP',
  'EUR',
  'INR',
  'ISK',
  'JPY',
  'KRW',
  'PLN',
  'NZD',
  'RUB',
  'SEK',
  'SGD',
  'THB',
  'TRY',
  'TWD',
];

Future getDataConversion() async {
  http.Response response = await http.get('https://blockchain.info/ticker');
  if (response.statusCode != 200) print('Can\'t find');
  return jsonDecode(response.body);
}