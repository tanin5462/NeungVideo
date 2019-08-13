import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neung_video/screens/home.dart';
import 'video_listview.dart';
import 'infomation.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Variable
  Color textColor = Colors.blueGrey[700];
  String nameLogin = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = VideoListView();
  Widget infomation = Infomation();

  // methods

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
  }

  Widget signOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.import_export,
        size: 36.0,
      ),
      title: Text('Sign Out'),
      onTap: () {
        signOutProcess();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> signOutProcess() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget showLogin() {
    return Text(
      'Logged in By $nameLogin',
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget mySizeBox() {
    return Container(
      width: 6.0,
      height: 6.0,
    );
  }

  Widget showAppName() {
    return Text(
      'Be12zebub',
      style: TextStyle(
        fontSize: 20.0,
        color: textColor,
        fontFamily: 'Prompt',
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 60.0,
      child: Image.asset(
        'images/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget myDrawerHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          Colors.white,
          Colors.blueGrey[700],
        ], radius: 1.5),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          mySizeBox(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myDrawerHead(),
          videoListMenu(),
          myDivider(),
          infomationMenu(),
          myDivider(),
          signOutMenu(),
          myDivider(),
        ],
      ),
    );
  }

  Widget videoListMenu() {
    return ListTile(
      leading: Icon(
        Icons.video_call,
        size: 36.0,
      ),
      title: Text('Video ListView'),
      onTap: () {
        setState(() {
          myWidget = VideoListView();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget infomationMenu() {
    return ListTile(
      onTap: () {
        setState(() {
          myWidget = Infomation();
          Navigator.of(context).pop();
        });
      },
      leading: Icon(
        Icons.info,
        size: 36.0,
      ),
      title: Text('InfomationMenu'),
    );
  }

  Widget myDivider() {
    return Divider(
      color: Colors.blueGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyService'),
      ),
      body: myWidget,
      drawer: myDrawerMenu(),
    );
  }
}
