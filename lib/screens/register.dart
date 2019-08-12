import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neung_video/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  Color color = Colors.blueGrey;

  final formKey = GlobalKey<FormState>();
  String name, email, password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Methods
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print("Clicked");

        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(name);
          print(email);
          print(password);
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print("SUCCESS");
      setupDisplayName();
    }).catchError((response) {
      print('response = ${response.toString()}');
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    // Create Thread Without Arrow Back
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
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
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        name = value;
      },
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
        validator: (String value) {
          value = value.trim();
          if (!((value.contains('@')) && (value.contains('.')))) {
            return 'Please Type Email Format';
          }
        },
        onSaved: (String value) {
          email = value;
        });
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
          hintText: '6 Character',
        ),
        validator: (String value) {
          if (value.length < 6) {
            return "Password Need More Than 6 Character";
          }
        },
        onSaved: (String value) {
          password = value;
        });
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
          child: Form(
            key: formKey,
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
      ),
    );
  }
}
