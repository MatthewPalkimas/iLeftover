import 'package:firebase_storage/firebase_storage.dart';
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
            backgroundColor: Color(0xFFCAE1FF),
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
          body: StreamBuilder(
            stream: Firestore.instance.collection("foodnew").snapshots(),
            builder: (context,snapshot) {
              if(!snapshot.hasData) 
                return Text('Loading data... Please wait...');

              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 370,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom : 8.0),
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Colors.black,
                            child: Center(child:Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(children:<Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: Image.network(
                                    '${ds['Image']}',
                                    fit: BoxFit.fill
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('${ds['Name']}',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.0),
                                Text('${ds['Description']}',
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.redAccent,
                                      onPressed: (){},  //code for chat function goes here
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.chat_bubble_outline),
                                          Text('Chat')
                                          ],
                                        )
                                      ),
                                      SizedBox(width:20),
                                      RaisedButton(
                                      color: Colors.greenAccent,
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Color(0xFFCAE1FF),
                                              title: Text('Food Reservation', textAlign: TextAlign.center,),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Text('Food Reserved!'),
                                                  RaisedButton(
                                                    onPressed: (){
                                                      _reserveupdate(ds.documentID);
                                                      _movedocument(ds.documentID);
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        
                                                      });},
                                                    color: Colors.greenAccent,
                                                    child: Row(
                                                      children: <Widget> [
                                                        Icon(Icons.arrow_back),
                                                        Text("Back"),
                                                      ],
                                                    ),
                                                    )
                                                ],
                                              ),
                                            );
                                          }
                                          );
                                        
                                      },  //code for chat function goes here
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.check_box),
                                          Text('Reserve')
                                          ],
                                      )
                                      )
                                  ],
                                )
                              ], 
                            ),
                            ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    ],
                    );
                }
              );
            },
          ),
      );
    }

    void _reserveupdate(String id)
    {
      final docref = Firestore.instance.collection('foodnew').document(id);
      docref.updateData({
        'Reserved': 'yes',
        });

    }

    Future _movedocument(String id) async{
      String user = await widget.auth.getuid();
      DocumentReference userdoc =  Firestore.instance.collection('users').document(user).collection('reservedfood').document(id);
      DocumentReference copyfrom =  Firestore.instance.collection('foodnew').document(id);
      copyfrom.get().then((data){
        userdoc.setData(data.data);
      });
      copyfrom.delete();
    } 
}
