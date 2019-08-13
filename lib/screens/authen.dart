import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neung_video/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Variable
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

  // Methods
  Widget emailText() {
    return TextFormField(
      onSaved: (String value) {
        emailString = value;
      },
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
      onSaved: (String value) {
        passwordString = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password :',
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              emailText(),
              passwordText(),
            ],
          ),
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

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      // MaterialPageRoute materialPageRoute = Material
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (BuildContext context) => MyService(),
      );
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            okButton(),
            cancleButton(),
          ],
        );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget cancleButton() {
    return FlatButton(
      child: Text("Cancle"),
      onPressed: () {
        Navigator.of(context).pop();
      },
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
        onPressed: () {
          formKey.currentState.save();
          checkAuthen();
          print('Email=$emailString,password=$passwordString');
        },
      ),
    );
  }
}
