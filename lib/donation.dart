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
            backgroundColor: Color(0xFF139427),
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
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                      padding: EdgeInsets.only(top: 25.0),
                      alignment: Alignment.center,
                      child: new Text("iLeftover", style: new TextStyle(
                        color: Color(0xFF139427), 
                        fontSize: 90.0,
                        shadows: [
                          Shadow( // bottomLeft
                            offset: Offset(-2, -2),
                            color: Color(0xFF0ea4b5)
                          ),
                          Shadow( // bottomRight
                            offset: Offset(2, -2),
                            color: Color(0xFF0ea4b5)
                          ),
                          Shadow( // topRight
                            offset: Offset(2, 2),
                            color: Color(0xFF0ea4b5)
                          ),
                          Shadow( // topLeft
                            offset: Offset(-2, 2),
                            color: Color(0xFF0ea4b5)
                          ),
                        ]
                        )
                        ),
                      ),
                    ],
                  ),
                  new Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(top:30.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFF139427)
                        ),
                        child: new Icon(Icons.local_offer,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top:150.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFF0394fc)
                        ),
                        child: new Icon(Icons.fastfood,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(right: 110.0, top:90.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFFFF0000)
                        ),
                        child: new Icon(Icons.home,color: Colors.white,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(left: 110.0, top:90.0),
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(80.0),
                          color: Color(0xFFFCAD03)
                        ),
                        child: new Icon(Icons.directions_car,color: Colors.white,),
                      ),
                    ],
                  ),
                  new Container(
                        child: Center(
                            child: new Column(
                              children: <Widget>[
                                new Padding(padding: EdgeInsets.only(top: 60.0)),
                                  new RaisedButton(
                                    child: new Text('Donation Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(1),
                                    textColor: Colors.white,
                                    color: Color(0xFF139427),
                                  ),
                                  new RaisedButton(
                                    child: new Text('Yoink Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(2),
                                    textColor: Colors.white,
                                    color: Color(0xFFFF0000)
                                  ),
                                  new RaisedButton(
                                    child: new Text('Maps Page', style: new TextStyle(fontSize: 20.0)),
                                    onPressed: () => changePage(3),
                                    textColor: Colors.white,
                                    color: Color(0xFFFCAD03)
                                  ),
                                ],
                              )
                          ),
                      ),
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