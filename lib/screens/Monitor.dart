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

  void deleteUrl (url) {
    setState(() {
      int index = urls.indexOf(url);
      urls.removeAt(index);
    });
  }

  List<Widget> _buildCards(List<String> urls) {

    return urls.map((String url) {
      return Dismissible(
        movementDuration: Duration(milliseconds: 10),
        key: UniqueKey(),
        onDismissed: (direction) {
          deleteUrl(url);
        },
        child: CardMonitor(color: Colors.pink, name: url),
      );
    }).toList();
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
              children: _buildCards(urls),
            ),
          )
        ],
      ),
    );
  }
}
