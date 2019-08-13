import 'package:flutter/material.dart';

class Infomation extends StatefulWidget {
  @override
  _InfomationState createState() => _InfomationState();
}

class _InfomationState extends State<Infomation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Infomation",
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }
}
