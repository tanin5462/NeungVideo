import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Variable

  // Methods
  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email :',
        helperText: 'Type your Email',
        helperStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Email :',
        helperText: 'More 7 Characters',
        helperStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget showTextBox() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(20, 255, 255, 255),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[emailText(), passwordText()],
        ),
      ),
    );
  }

  Widget backButton() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        top: 38.0,
        left: 12.0,
      ),
      child: IconButton(
        icon: Icon(
          Icons.navigate_before,
          color: Colors.white,
          size: 36.0,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            backButton(),
            showTextBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.navigate_next,
          size: 36.0,
        ),
        onPressed: () {},
      ),
    );
  }
}
