import 'package:flutter/material.dart';
import 'auth.dart';

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
          body: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('Assets/wood-texture.jpg'),
              fit: BoxFit.cover,
              ),
            ),
            child: new Container(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: 140.0)),
                      new Text(
                         'Yoink Page',
                          style: new TextStyle(color: Colors.green, fontSize: 25.0),
                      ),
                      new Padding(
                         padding: EdgeInsets.only(top: 50.0)
                      ),
                    ],
                  )
              ),
            )
          ),
      );
    }
}