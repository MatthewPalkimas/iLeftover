import 'package:flutter/material.dart';
import 'auth.dart';
import 'login_page.dart';


class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}


class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState(){
    super.initState(); 
    widget.auth.currentUser().then((userId){
      setState(() {
       // authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }


  @override 
  Widget build(BuildContext context){
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
        );
      case AuthStatus.signedIn:
       return new Scaffold(
         body: Container(
         child: new Text('welcome')),
       );
    }
  }
}