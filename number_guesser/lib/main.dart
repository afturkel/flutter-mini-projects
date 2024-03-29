import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Guessing Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Number Guesser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController numberInput = TextEditingController();

  int numberToGuess = 0;
  int points = 0;

  void numGuess() {
    Random generateRandom = Random();
    setState(() {
      numberToGuess = generateRandom.nextInt(5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Text('Your points: $points'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Guess the secret number:\n',
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: numberInput,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a number',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int guessedNumber = int.tryParse(numberInput.text) ?? 0;
          if (guessedNumber == numberToGuess) {
            setState(() {
              points++;
            });
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Congratulations!'),
                content: Text('You guessed the correct number: $numberToGuess'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      numGuess();
                      numberInput.clear();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Try Again'),
                content: Text('The correct number is $numberToGuess'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      numGuess();
                      numberInput.clear();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: const Text('Guess'),
      ),
    );
  }
}
