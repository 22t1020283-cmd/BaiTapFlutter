import 'package:flutter/material.dart';

class BT4Counter extends StatefulWidget {
  const BT4Counter({super.key});

  @override
  State<BT4Counter> createState() => _BT4CounterState();
}

class _BT4CounterState extends State<BT4Counter> {
  int _currentValue = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tính năng tăng/giảm')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Giá trị hiện tại:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(
              '$_currentValue',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentValue--;
                    });
                  },
                  child: const Text(
                    '- Giảm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentValue = 0;
                    });
                  },
                  child: const Text('Đặt lại'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentValue++;
                    });
                  },
                  child: const Text('+ Tăng'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
