import 'package:flutter/material.dart';

class CardMonitor extends StatelessWidget {

  final Color color;
  final String name;

  CardMonitor({
    @required this.color,
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 100.0,
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
