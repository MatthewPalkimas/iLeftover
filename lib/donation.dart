import 'package:flutter/material.dart';
import 'auth.dart';
import 'profile.dart';
import 'statement.dart';
import 'home.dart';

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
      if (pageNum == 0)
        HomePage2.goHome();
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
    List<Widget> _children = [
        HomePage2(
          auth: widget.auth,
          onSignedOut: widget._signOut,
        ),
        ProfilePage(
            auth: widget.auth,
            onSignedOut: widget._signOut,
            goBack: defaultPage
        ),
        Page4(
            auth: widget.auth,
            onSignedOut: widget._signOut,
            goBack: defaultPage
          ),
      ];
      return new Scaffold(
          body: _children[pageNumber],
          bottomNavigationBar: new BottomNavigationBar(
            onTap: changePage,
            currentIndex: pageNumber,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
                ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: new Text('Profile'),
                ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.satellite),
                title: new Text('About Us'),
              ),
             ],
          ),
        );
    }
  }