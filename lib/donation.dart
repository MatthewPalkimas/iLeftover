import 'package:flutter/material.dart';
import 'auth.dart';
import 'state1.dart';
import 'state2.dart';
import 'maps.dart';
import 'statement.dart';

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
            // backgroundColor: Color(0xFFC4CACF),
            backgroundColor: Color(0xFFCAE1FF),
            actions: <Widget>[
            new FlatButton(
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: widget._signOut
              )
            ],
          ),
          body: new Container(
            
            child: new Container(
              child: Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                      'Assets/LOGO.png',
                      width: 300,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    ],
                  ),
                    new Container(
                        child: Center(
                            child: new Column(
                              children: <Widget>[
                                new Padding(padding: EdgeInsets.only(top: 10.0)),
                                  new RawMaterialButton(
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                      new Icon(
                                      Icons.local_offer,
                                      color: Colors.white,
                                      size: 70.0
                                      ),
                                      new Text(
                                        'Donate',
                                        style: TextStyle(fontSize: 40, color: Colors.black)
                                      ),
                                    ]
                                    ),
                                    onPressed: () => changePage(1),
                                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 2.0,
                                    fillColor: Color(0xFF7180A9),
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 30.0)),
                                  new RawMaterialButton(
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                      new Icon(
                                      Icons.fastfood,
                                      color: Colors.white,
                                      size: 70.0
                                      ),
                                      new Text(
                                        'Yoink',
                                        style: TextStyle(fontSize: 40, color: Colors.black)
                                      ),
                                    ]
                                    ),
                                    onPressed: () => changePage(2),
                                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 2.0,
                                    fillColor: Color(0xFFCAE1FF),
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 30.0)),
                                  new RawMaterialButton(
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                      new Icon(
                                      Icons.drive_eta,
                                      color: Colors.white,
                                      size: 70.0
                                      ),
                                      new Text(
                                        'Explore',
                                        style: TextStyle(fontSize: 40, color: Colors.black)
                                      ),
                                    ]
                                    ),
                                    onPressed: () => changePage(3),
                                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 2.0,
                                    fillColor: Color(0xFF84D9FF),
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 60.0)),
                                  new RawMaterialButton(
                                    child: new Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 35.0
                                    ),
                                    onPressed: () => changePage(4),
                                    shape: new CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Color(0xFF98B4D4),
                                    padding: const EdgeInsets.all(15.0),
                                  )
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
      case 4:
        return new Page4(
          auth: widget.auth,
          onSignedOut: widget._signOut,
          goBack: defaultPage
      );
    }
  }
}