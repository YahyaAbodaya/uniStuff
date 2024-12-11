import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestApp(),
    );
  }
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  double _userInput = 0;
  String? _convertedMeasure;
  String errorMessage = '';
  String? _startValue;

  final List<String> fromUnits = [
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'ounces'
  ];

  final Map<String, int> measuresMap = {
    'Meters': 0,
    'Kilometer': 1,
    'Grams': 2,
    'Kilograms (kg)': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds (lbs)': 6,
    'ounces': 7
  };

  final dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.280, 0.0006213, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0, 6213, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220, 0.03],
    '3': [0, 0, 1000, 1, 0, 0, 2.2046, 35.274],
    '4': [0.0348, 0.00030, 0, 0, 1, 0.000189, 0],
    '5': [1609.34, 1.60934, 0, 5280, 1, 0, 0, 0],
    '6': [0, 0, 453.592, 0.4535, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.02834, 3.28084, 0, 0, 1]
  };

  void converter(double value, String from, String to) {
    int? nFrom = measuresMap[from];
    int? nTo = measuresMap[to];
    var multiplier = formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      errorMessage = 'Cannot perform this conversion';
    } else {
      errorMessage =
      '$_userInput $_startValue are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      errorMessage = errorMessage;
    });
  }

  @override
  void initState() {
    _userInput = 0;
    _startValue = fromUnits[0];
    _convertedMeasure = fromUnits[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                const Text(
                  'Convert!',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: TextField(
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Enter a Value',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onChanged: (text) {
                      var input = double.tryParse(text);
                      if (input != null) {
                        setState(() {
                          _userInput = input;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'From',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Choose a Unit',
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.black,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                        items: fromUnits.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _startValue = value;
                          });
                        },
                        value: _startValue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Choose a Unit',
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.black,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                        items: fromUnits.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _convertedMeasure = value;
                          });
                        },
                        value: _convertedMeasure,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    onPressed: () {
                      if (_startValue == null ||
                          _convertedMeasure == null ||
                          _userInput == 0) {
                        return;
                      } else {
                        converter(
                            _userInput, _startValue!, _convertedMeasure!);
                      }
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Convert',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
