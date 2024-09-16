import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UserCode Calculator', // Set your name here
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UserCode Calculator'), // Set your name here
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = '';
  String _result = '';

  void _onPressed(String input) {
    setState(() {
      if (input == '=') {
        _calculateResult();
      } else if (input == 'C') {
        _expression = '';
        _result = '';
      } else {
        _expression += input;
      }
    });
  }

  void _calculateResult() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      var evalResult = evaluator.eval(expression, {});
      setState(() {
        _result = evalResult.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _onPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7', Colors.blue),
                  _buildButton('8', Colors.blue),
                  _buildButton('9', Colors.blue),
                  _buildButton('/', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Colors.blue),
                  _buildButton('5', Colors.blue),
                  _buildButton('6', Colors.blue),
                  _buildButton('*', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Colors.blue),
                  _buildButton('2', Colors.blue),
                  _buildButton('3', Colors.blue),
                  _buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', Colors.blue),
                  _buildButton('C', Colors.red),
                  _buildButton('=', Colors.green),
                  _buildButton('+', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
