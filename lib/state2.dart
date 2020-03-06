import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Page2 extends StatefulWidget {
  Page2({this.auth, this.onSignedOut, this.goBack});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback goBack;

  @override
  State<StatefulWidget> createState() => new _Page2PageState();
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class _Page2PageState extends State<Page2>{

  @override
    Widget build(BuildContext context)
    {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF139427),
            actions: <Widget>[
            new FlatButton(
                child: new Text('Back', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: widget.goBack
              ),
            new FlatButton(
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: widget._signOut
              )
            ],
          ),
          body:StreamBuilder(
            stream: Firestore.instance.collection('Foodinfo').document('food').snapshots(),
            builder: (context,snapshot) {
              if(!snapshot.hasData) 
                return Text('Loading data... Please wait...');
              return Column(
                children: <Widget> [
                  Text(snapshot.data.documents[0]['FoodName']),
                  Text(snapshot.data.documents[0]['FoodType']) 
                ],
              );
            },
          )
      );
    }
}