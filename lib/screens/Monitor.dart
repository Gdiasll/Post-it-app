import 'package:flutter/material.dart';
import '../components/CardMonitor.dart';
import '../components/Formulary.dart';

class Monitor extends StatefulWidget {

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {

  List<String> urls = [];
  bool formVisible = false;

  void formularyCallback (String url) {
    setState(() {
      urls.add(url);
    });
    formVisible = !formVisible;
  }

  Widget handleForm (formVisible) {
    return formVisible ? 
      Formulary(callBack: this.formularyCallback,) :
      Padding(padding: EdgeInsets.all(10.0),);
  }

  void togleForm () {
    setState(() {
      formVisible = !formVisible;
    });
  }

  List<Widget> _buildCards(List<String> urls) {
    List<Widget> data = [];
    for (int i = 0; i < urls.length; i++) {
      data.add(
        Dismissible(
          movementDuration: Duration(milliseconds: 100),
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              urls.removeAt(i);
            });
          },
          child: CardMonitor(color: Colors.pink, name: urls[i],),
        )
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monitor',
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
          // Column(
          //   children: _buildCards(urls),
          // )
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2, 
              children: _buildCards(urls),
            ),
          )
        ],

      ),
    );
  }
}
