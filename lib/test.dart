import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class SlotItem extends StatelessWidget {
  final String text;

  const SlotItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80.0,
      child: Text(
        text,
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }
}

class SlotMachine extends StatefulWidget {
  final List<String> items1;
  final List<String> items2;
  final List<String> items3;

  const SlotMachine({
    Key? key,
    required this.items1,
    required this.items2,
    required this.items3,
  }) : super(key: key);

  @override
  _SlotMachineState createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Timer _timer;
  bool _isSpinning = false;
  List<String> _items1 = [];
  List<String> _items2 = [];
  List<String> _items3 = [];

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller2 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller3 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _items1 = List.from(widget.items1);
    _items2 = List.from(widget.items2);
    _items3 = List.from(widget.items3);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  void _shuffleItems() {
    setState(() {
      _items1.shuffle();
      _items2.shuffle();
      _items3.shuffle();
    });
  }
  int getRandomNumber() {
    var rng = Random();
    int min = 150;
    int max = 350;
    int randomNumber = min + rng.nextInt(max - min + 1);
    return randomNumber;
  }
  void _startSpinning() {


    setState(() {
      _isSpinning = true;
    });
    _shuffleItems();
    const int spinDuration = 3; // тривалість обертання в секундах
    _controller1.repeat(period: Duration(milliseconds: getRandomNumber()));
    _controller2.repeat(period: Duration(milliseconds: getRandomNumber()));
    _controller3.repeat(period: Duration(milliseconds: getRandomNumber()));

    _timer = Timer(Duration(seconds: spinDuration), () {
      setState(() {
        _isSpinning = false;
      });
      _controller1.stop();
      _controller2.stop();
      _controller3.stop();
      _checkForMatches();
    });
  }

  void _checkForMatches() {
    int index1 = (_controller1.value * _items1.length).floor() % _items1.length;
    int index2 = (_controller2.value * _items2.length).floor() % _items2.length;
    int index3 = (_controller3.value * _items3.length).floor() % _items3.length;

    List<String> row1 = [_items1[index1], _items2[index2], _items3[index3]];
    List<String> row2 = [
      _items1[(index1 + 1) % _items1.length],
      _items2[(index2 + 1) % _items2.length],
      _items3[(index3 + 1) % _items3.length]
    ];
    List<String> row3 = [
      _items1[(index1 + 2) % _items1.length],
      _items2[(index2 + 2) % _items2.length],
      _items3[(index3 + 2) % _items3.length]
    ];

    if (_allElementsEqual(row1) || _allElementsEqual(row2) || _allElementsEqual(row3)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have matched three items in a row!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool _allElementsEqual(List<String> items) {
    return items.every((element) => element == items[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSlot(_items1, _controller1),
            _buildSlot(_items2, _controller2),
            _buildSlot(_items3, _controller3),
          ],
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _isSpinning ? null : _startSpinning,
          child: Text('SPIN'),
        ),
      ],
    );
  }

  Widget _buildSlot(List<String> items, AnimationController controller) {
    return Container(
      height: 250.0,
      width: 100,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemExtent: 80.0,
            itemCount: items.length * 3, // повторимо елементи тричі для безперервного прокручування
            itemBuilder: (context, i) {
              double offset = controller.value * items.length * 80.0; // Обчислення зсуву анімації
              int index = (i + offset ~/ 80) % items.length;
              return SlotItem(text: items[index]);
            },
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Index Slot Machine'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SlotMachine(
              items1: ['🍎', '🍌', '🍒'],
              items2: ['🍒', '🍎', '🍌'],
              items3: ['🍌', '🍒', '🍎'],
            ),
          ),
        ),
      ),
    );
  }
}
