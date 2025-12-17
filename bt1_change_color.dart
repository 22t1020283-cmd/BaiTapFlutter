import 'package:flutter/material.dart';
import 'dart:math';

class BT1ChangeColor extends StatefulWidget {
  const BT1ChangeColor({super.key});

  @override
  State<BT1ChangeColor> createState() => _BT1ChangeColorState();
}

class _BT1ChangeColorState extends State<BT1ChangeColor> {
  Color _bgColor = Colors.green;
  String _colorName = 'Xanh lá';

  final List<Map<String, dynamic>> colors = [
    {'color': Colors.green, 'name': 'Xanh lá'},
    {'color': Colors.red, 'name': 'Đỏ'},
    {'color': Colors.blue, 'name': 'Xanh dương'},
    {'color': Colors.yellow, 'name': 'Vàng'},
    {'color': Colors.purple, 'name': 'Tím'},
    {'color': Colors.orange, 'name': 'Cam'},
    {'color': Colors.pink, 'name': 'Hồng'},
    {'color': Colors.teal, 'name': 'Lục xanh'},
  ];

  void _changeColor(Color color, String name) {
    setState(() {
      _bgColor = color;
      _colorName = name;
    });
  }

  void _changeRandomColor() {
    final random = Random();
    final randomIndex = random.nextInt(colors.length);
    final randomColorItem = colors[randomIndex];
    _changeColor(
      randomColorItem['color'] as Color,
      randomColorItem['name'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _colorName,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _bgColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _changeRandomColor,
              child: Text(
                'Change Color',
                style: TextStyle(
                  color: _bgColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colors.map((colorItem) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorItem['color'] as Color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    _changeColor(
                      colorItem['color'] as Color,
                      colorItem['name'] as String,
                    );
                  },
                  child: Text(
                    colorItem['name'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
