import 'dart:math';
import 'package:flutter/material.dart';
import '../components/CardMonitor.dart';
import '../components/Formulary.dart';
import '../models/cards.dart';

class Monitor extends StatefulWidget {
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  CardModel cardModel = new CardModel();
  List<dynamic> colors = [
    0xFFF48FB1,
    0xFFF06292,
    0xFFE57373,
    0xFFFFF176,
    0xFF81C784,
    0xFF64B5F6,
  ];
  Map<String, int> cards = {};
  bool formVisible = false;

  Widget handleForm(formVisible) {
    return formVisible
        ? Formulary(
            callBack: this.formularyCallback,
          )
        : Padding(
            padding: EdgeInsets.all(10.0),
          );
  }

  int get color {
    var random = new Random();
    return colors[random.nextInt(colors.length)];
  }

  void formularyCallback(String nome) {
    int colorCard = color;
    cardModel.setCard({nome: colorCard}).then((param) => this.updateCards());
    formVisible = !formVisible;
  }

  void togleForm() {
    setState(() {
      formVisible = !formVisible;
    });
  }

  void deleteCard(key) {
    cardModel.deletCard(key).then((param) => this.updateCards());
  }

  void updateCards() {
    cardModel.getCards().then((dataCards) {
      setState(() {
        cards = new Map<String, int>.from(dataCards);
      });
    });
  }

  List<Widget> _buildCards(Map<String, int> cards) {
    List<Widget> payload = [];
    cards.forEach((String texto, int cor) {
      payload.add(Dismissible(
        movementDuration: Duration(milliseconds: 10),
        key: UniqueKey(),
        onDismissed: (direction) {
          deleteCard(texto);
        },
        child: CardMonitor(color: Color(cor) , name: texto),
      ));
    });
    return payload;
  }

  @override
  void initState() {
    updateCards();
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
