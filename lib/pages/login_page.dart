import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title = "Login Page";
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
        child: new Form(
          child: new Column(children: <Widget>[
            new TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            new TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            new RaisedButton(
              child: new Text("Login"),
              onPressed: null,
            ),
          ]),
        ),
      ),
    );
  }
}
