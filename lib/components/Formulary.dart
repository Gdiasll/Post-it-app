import 'package:flutter/material.dart';

class Formulary extends StatelessWidget {
  final myController = TextEditingController();
  final Function callBack;

  Formulary({
    @required this.callBack
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'URL',
            ),
            controller: myController,
            onFieldSubmitted: (String value) { callBack(myController.text); },
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          RaisedButton(
            onPressed: () { callBack(myController.text); },
            autofocus: false,
            clipBehavior: Clip.antiAlias,
            elevation: 5.0,
            color: Colors.grey,
            child: Container(
              padding:
                  EdgeInsets.only(left: 7.5, bottom: 5.0, top: 5.0, right: 7.5),
              child: Text('OK'),
            ),
          )
        ],
      ),
    );
  }
}
