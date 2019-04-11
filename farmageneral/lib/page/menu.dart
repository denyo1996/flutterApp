import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(title: Text('pagina del menu'),),
      body: new Column(
        children: <Widget>[ 
          new Text('Estamos en el menu'),
          RaisedButton(
            child: Text("Salir"),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
          )
        ],
      ),
    );
  }
}