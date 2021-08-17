import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

const kApikey = '7F66F50F-0BF0-4312-9C22-004086A23B6F';
double exchaneRate = 0.0;

Future<double> getNetworkInfo() async {
  var url =
      get('https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$kApikey');
  Response response = await url;
  if (response.statusCode == 200) {
    String body = response.body;
    var apiData = jsonDecode(body);
    exchaneRate = apiData['rate'];
  } else {
    print(response.statusCode);
    exchaneRate = 0;
  }
  return await exchaneRate;
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = "USD";

  DropdownButton androidDropButton() {
    List<DropdownMenuItem> currencies = [];
    for (String cur in currenciesList) {
      Widget currency = DropdownMenuItem(
        value: cur,
        child: Text(cur),
      );
      currencies.add(currency);
    }
    return DropdownButton(
      value: currentCurrency,
      items: currencies,
      onChanged: (value) {
        setState(() {
          currentCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencies = [];
    for (String cur in currenciesList) {
      Widget currency = Text(cur);
      currencies.add(currency);
    }
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 9),
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
      },
      children: currencies,
    );
  }

  void testing() async {
    double exchange = await getNetworkInfo();
    print(exchange);
  }

  @override
  void initState() {
    testing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropButton(),
          ),
        ],
      ),
    );
  }
}
