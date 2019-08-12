import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  Color color = Colors.blueGrey;

  // Methods
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[100]),
        ),
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: Colors.blue[600],
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: Colors.blueGrey),
        helperText: 'Type Name in English',
        helperStyle: TextStyle(color: Colors.blueGrey),
        hintText: 'FirstName SecondName',
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[100]),
        ),
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: Colors.green[600],
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.blueGrey),
        helperText: 'Type in Email Format',
        helperStyle: TextStyle(color: Colors.blueGrey),
        hintText: 'Email@hotmail.com',
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[100]),
        ),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.orange[600],
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.blueGrey),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: Colors.blueGrey),
        hintText: 'Capital Letter,More 6 Character',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          registerButton(),
        ],
        backgroundColor: color,
        title: Text("Register"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              colors: [Colors.white, Colors.blueGrey[400]],
              radius: 1.5,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              nameText(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }
}
