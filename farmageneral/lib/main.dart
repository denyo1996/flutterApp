import 'dart:convert';

import 'package:farmageneral/page/menu.dart';
import 'package:farmageneral/page/powerPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());
 
String username='';

class LoginApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmageneral',     
      home: LoginPage(),
      routes: <String,WidgetBuilder>{
        '/powerPage':(BuildContext context) => new Power(),
        '/menu':(BuildContext context) => new Menu(),
        '/LoginPage':(BuildContext context) => LoginPage(),  
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
  
}
class _LoginPageState extends State<LoginPage> {
  _LoginPageState createState() => _LoginPageState();
  
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String mensaje ='';

  Future<List> login() async {
    final response= await http.post("http://192.168.1.4/farmageneral/login.php", body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });
  
  var datauser = json.decode(response.body);

  if(datauser.length == 0){
    setState(() {
     mensaje="usuario o clave incorrecta"; 
    });
  } 
  setState(() {
   username=datauser[0]['username']; 
  });

  return datauser;
}  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/img/digital.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 77.0),
                child: new CircleAvatar(
                  backgroundColor: Color(0xF81F7F3),
                  child: new Image(
                    width: 135,
                    height: 135,
                    image: new AssetImage('assets/img/avatar1.png'),
                  ),
                ),
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle
              )),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 50
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 5
                           )
                        ]
                      ),
                      child: TextFormField(
                        controller: controllerUser,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'User'
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(
                        top: 32
                      ),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextField(
                        controller: controllerPass ,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'Password'
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight ,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 32,
                        ),
                        child: Text(
                          'Recordar Password',
                          style: TextStyle(
                             color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    new RaisedButton(
                      child: new Text("Ingresar"),
                      color: Colors.lightBlue,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                      ),
                      onPressed: (){
                        login();
                        Navigator.pop(context);
                      }
                    ),
                    Text(mensaje,
                    style:TextStyle( fontSize: 10.0, color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


