import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neung_video/screens/authen.dart';
import 'package:neung_video/screens/my_service.dart';
import 'package:neung_video/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit (Variable)
  double mySizeLogo = 120.0;
  Color myColor = Color.fromARGB(0xFF, 0x00, 0x3c, 0x8f);
  // Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget showLogo() {
    return Container(
      width: mySizeLogo,
      height: mySizeLogo,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      "BE12ZEBUB",
      style: TextStyle(
        fontSize: 30.0,
        color: myColor,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Prompt',
      ),
    );
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        children: <Widget>[
          signInButton(),
          mySizeBox(),
          signUpButton(),
          mySizeBox(),
        ],
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: myColor,
        child: Text(
          'signIn',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Authen());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: myColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'signUp',
          style: TextStyle(color: myColor),
        ),
        onPressed: () {
          //  Create Route With Arrow Back
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 12.0,
      height: 24.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.9,
              colors: [
                Colors.white,
                Colors.blueGrey[600],
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showLogo(),
              showAppName(),
              mySizeBox(),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
