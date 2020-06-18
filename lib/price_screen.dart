import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/three_cards.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

String selectedCurrency = 'USD';
String conversionValue = '?';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    selectedCurrency = 'USD';
    getData();
  }

  void getData() async {
    var data = await getDataConversion();
    setState(() {
      conversionValue = (data[selectedCurrency]['buy']).toString();
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownButtonItems = [];
    for (String currency in currenciesList) {
      dropdownButtonItems.add(
        DropdownMenuItem<String>(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      items: dropdownButtonItems,
      value: selectedCurrency,
      onChanged: (String val) {
        setState(() {
          selectedCurrency = val;
          conversionValue = '?';
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> children = [];
    for (String currency in currenciesList) {
      children.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          conversionValue = '?';
          getData();
        });
      },
      children: children,
    );
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
              child: Column(
                children: <Widget>[
                  ThreeCards(coin: 'BTC'),
                  ThreeCards(coin: 'ETH'),
                  ThreeCards(coin: 'LTC'),
                ],
              ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}