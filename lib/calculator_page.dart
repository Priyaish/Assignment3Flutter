import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  String _result = '';

  void _calculate(String operation) {
    setState(() {
      final num1 = double.tryParse(_num1Controller.text) ?? 0;
      final num2 = double.tryParse(_num2Controller.text) ?? 0;
      
      double calculationResult;

      switch (operation) {
        case 'Add':
          calculationResult = num1 + num2;
          break;
        case 'Subtract':
          calculationResult = num1 - num2;
          break;
        case 'Multiply':
          calculationResult = num1 * num2;
          break;
        case 'Divide':
          if (num2 == 0) {
            _result = 'Cannot divide by zero';
            return;
          }
          calculationResult = num1 / num2;
          break;
        default:
          _result = 'Unknown operation';
          return;
      }

      _result = calculationResult.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter first number',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter second number',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate('Add'),
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Subtract'),
                  child: Text('Subtract'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Multiply'),
                  child: Text('Multiply'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Divide'),
                  child: Text('Divide'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
