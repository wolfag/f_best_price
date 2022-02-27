import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
}

final List<Product> productList = [
  Product(name: "p1", price: 1),
  Product(name: "p2", price: 1),
  Product(name: "p3", price: 1),
  Product(name: "p4", price: 1),
  Product(name: "p5", price: 1),
  Product(name: "p6", price: 1),
  Product(name: "p7", price: 1),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentProductIndex = 0;
  int? _price;
  String _result = '';
  bool _visibleNext = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(productList[_currentProductIndex].name),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 200,
                child: TextField(
                  key: const Key('priceInput'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    setState(() {
                      _price = int.tryParse(value);
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: _visibleNext,
              child: Text(
                _result,
                key: const Key('result'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = _price == productList[_currentProductIndex].price
                      ? 'Pass'
                      : 'Fail';
                  _visibleNext = true;
                });
              },
              child: const Text('Check'),
            ),
            Visibility(
              visible: _visibleNext,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentProductIndex < productList.length - 1) {
                      _currentProductIndex++;
                    }
                    _visibleNext = false;
                    _result = '';
                  });
                },
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
