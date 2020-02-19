import 'dart:math';

import 'package:flutter/material.dart';
import '../components/CardMonitor.dart';
import '../components/Formulary.dart';

class Monitor extends StatefulWidget {

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {

  List<Color> colors = [Colors.pink, Colors.pinkAccent, Colors.red, Colors.yellow, Colors.blue, Colors.green, Colors.lightBlue];
  Map<String, Color> cards = {};
  bool formVisible = false;

  Widget handleForm (formVisible) {
    return formVisible ? 
      Formulary(callBack: this.formularyCallback,) :
      Padding(padding: EdgeInsets.all(10.0),);
  }

  Color get color {
    var random = new Random();
    return colors[random.nextInt(colors.length)];
  }

  void formularyCallback (String url) {
    setState(() {
      cards[url] = color;
    });
    formVisible = !formVisible;
  }

  void togleForm () {
    setState(() {
      formVisible = !formVisible;
    });
  }

  void deleteUrl (texto) {
    setState(() {
      cards.remove(texto);
    });
  }

  List<Widget> _buildCards(Map<String, Color> cards) {
    List<Widget> payload = [];
    cards.forEach((String texto, Color cor) {
      payload.add(Dismissible(
        movementDuration: Duration(milliseconds: 10),
        key: UniqueKey(),
        onDismissed: (direction) {
          deleteUrl(texto);
        },
        child: CardMonitor(color: cor, name: texto),
      ));
    });
    return payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post-it',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Adicionar card',
            onPressed: togleForm,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          handleForm(formVisible),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2, 
              children: _buildCards(cards),
            ),
          )
        ],
      ),
    );
  }
}
