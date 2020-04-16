import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Reservepage extends StatefulWidget {
  Reservepage({this.auth, this.onSignedOut, this.goBack});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback goBack;
  

  @override
  State<StatefulWidget> createState() => new _ReservepageState();
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class _ReservepageState extends State<Reservepage>{
  String uid;
  @override 
  Widget build(BuildContext context){
   getuid();
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
            stream: Firestore.instance.collection("users").document(uid).collection('reservedfood').snapshots(),
            builder: (context,snapshot) {
              if(!snapshot.hasData) 
                return Center(child: 
                Text('No Active Reservations!',
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic
                ),
                )
                );
               {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Container(
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 5.0,
                        color: Colors.red[100],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black87, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height:115,
                                width:115,
                                child: Image.network('${ds['Image']}',fit: BoxFit.fill,),
                              ),
                              SizedBox(width:80),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('${ds['Name']}',style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Text('${ds['Description']}',style: TextStyle(
                                    fontSize:15.5,
                                  ),),
                                  Text(
                                    DateFormat('kk:mm EEE d MMM').format(ds['Time'].toDate()),
                                  )
                                ],
                                
                              )                            
                            ],
                            
                        )
                      ),
                  ),
                    ));
                  }
                  
                  );
              }
            }
          )
        );
  }

 Future getuid() async {
     await  widget.auth.getuid().then((result){
       setState(() {
         uid = result;
       });});
  }
}