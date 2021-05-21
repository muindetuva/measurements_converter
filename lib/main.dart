import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _startMeasure;
  String _convertedMeasure;
  double _numberFrom;
  String _resultMessage;

  @override
  Widget build(BuildContext context) {
    void initState() {
      _numberFrom = 0;
      super.initState();
    }
    final TextStyle inputStyle = TextStyle(
        fontSize: 20,
        color: Colors.black,
    );
    final TextStyle labelStyle = TextStyle(
        fontSize: 24,
        color: Colors.grey[700]
    );
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces'
    ];
    final Map<String, int> _measuresMap = {
      'meters' : 0,
      'kilometers' : 1,
      'grams' : 2,
      'kilograms' : 3,
      'feet' : 4,
      'miles' : 5,
      'pounds (lbs)' : 6,
      'ounces' : 7,
    };
    final dynamic _formulas = {
      '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
      '1':[1000,1,0,0,3280.84,0.621371,0,0],
      '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
      '3':[0,0,1000,1,0,0,2.20462,35.274],
      '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
      '5':[1609.34, 1.60934,0,0,5280,1,0,0],
      '6':[0,0,453.592,0.453592,0,0,1,16],
      '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
    };
    void convert(double value, String from, String to){
      int nFrom = _measuresMap[from];
      int nTo = _measuresMap[to];
      var multiplier = _formulas[nFrom.toString()][nTo];
      var result = value * multiplier;

      if (result == 0){
        _resultMessage = 'This conversion cannot be done';
      }else{
        _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
      }
      setState(() {
        _resultMessage = _resultMessage;
      });
    }

    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Spacer(),
              Text(
                'Value',
                style: labelStyle,
              ),
              Spacer(),
              TextField(
                onChanged: (text){
                  var rv = double.tryParse(text);
                  if (rv != null){
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
                style: inputStyle,
                decoration: InputDecoration(
                  hintText: "Please insert measure to be converted"
                ),
              ),
              Spacer(),
              Text(
                'from',
                style: labelStyle,
              ),
              DropdownButton(
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value),);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
                value: _startMeasure,
                isExpanded: true,
                style: inputStyle,
              ),
              Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              Spacer(),
              DropdownButton(
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value),);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure =  value;
                  });
                },
                value: _convertedMeasure,
                isExpanded: true,
                style: inputStyle,
              ),
              Spacer(
                flex: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom == 0){
                    return;
                  }else{
                    convert(_numberFrom, _startMeasure, _convertedMeasure);
                  }
                },
                child: Text(
                  'Convert',
                  style: inputStyle,
                )
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                (_resultMessage == null) ? '': _resultMessage,
                style: labelStyle,
              ),
              Spacer(
                flex: 8,
              )
            ],
          ),
        ),
      ),

    );

  }




}
