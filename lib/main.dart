import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monitor/screens/Monitor.dart';

void main() => runApp(MonitorApp());

class MonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monitor App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Monitor(),
    );
  }
}
