import 'package:flutter/material.dart';
import 'auth.dart';
import 'state1.dart';
import 'state2.dart';
import 'maps.dart';

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

  void changePage(int pageNum) {
    setState(() {
      pageNumber = pageNum;
    });
  }

  void defaultPage() {
    setState(() {
      pageNumber = 0;
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
              child: Column(
                children: <Widget>[
                  new Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(top:40.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFF18D191)
                        ),
                        child: new Icon(Icons.local_offer,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top:160.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFF0394fc)
                        ),
                        child: new Icon(Icons.fastfood,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(right: 110.0, top:100.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFFFC6A7F)
                        ),
                        child: new Icon(Icons.home,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(left: 110.0, top:100.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFFFFCE56)
                        ),
                        child: new Icon(Icons.directions_car,color: Colors.white,),
                      ),
                    ],
                  ),
                  new Container(
                        child: Center(
                            child: new Column(
                              children: <Widget>[
                                new Padding(padding: EdgeInsets.only(top: 80.0)),
                                  new RaisedButton(
                                    child: new Text('Donation Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(1)
                                  ),
                                  new RaisedButton(
                                    child: new Text('Yoink Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(2)
                                  ),
                                  new RaisedButton(
                                    child: new Text('Maps Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(3)
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(top: 50.0)
                                  ),
                                ],
                              )
                          ),
                      ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("iLeftover", style: new TextStyle(color: Colors.lightGreen, fontSize: 30.0), )
                    ],
                  )
                ],
              )
            ),
          ),
        );
      case 1:
       return new Page1(
         auth: widget.auth,
         onSignedOut: widget._signOut,
         goBack: defaultPage
      );
      case 2:
       return new Page2(
         auth: widget.auth,
         onSignedOut: widget._signOut,
         goBack: defaultPage
      );
      case 3:
       return new Page3(
         auth: widget.auth,
         onSignedOut: widget._signOut,
         goBack: defaultPage
      );
    }
  }
}