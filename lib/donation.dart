import 'package:flutter/material.dart';
import 'auth.dart';
import 'state1.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
    void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}



class _HomePageState extends State<HomePage>{
  int pageNumber = 0;

  void change_page() {
    setState(() {
      pageNumber = 1;
    });
  }

  @override 
  Widget build(BuildContext context){
    switch(pageNumber){
      case 0:
        return new Scaffold(
          appBar: new AppBar(
            actions: <Widget>[
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
                         'Donate Food in Your Area',
                          style: new TextStyle(color: Colors.green, fontSize: 25.0),
                      ),
                      new RaisedButton(
                        child: new Text('Next Page', style: new TextStyle(fontSize: 20.0)),
                        onPressed: change_page
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
      case 1:
       return new Page1(
         auth: widget.auth,
         onSignedOut: widget._signOut
      );
    }
  }
}