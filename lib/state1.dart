import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class Page1 extends StatefulWidget {
  Page1({this.auth, this.onSignedOut, this.goBack});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback goBack;

  @override
  State<StatefulWidget> createState() => new _Page1PageState();
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class _Page1PageState extends State<Page1>{
  String _name, _description, _imageurl;
   final formKey = GlobalKey<FormState>();


  @override
    Widget build(BuildContext context)
    {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFFCAE1FF),
            actions: <Widget>[
            new FlatButton(
                child: new Text('Back', style: new TextStyle(fontSize: 17.0, color: Colors.white),),
                onPressed: widget.goBack
                
              ),
            new FlatButton(
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: widget._signOut
              )
            ],
          ),
          body: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name of your food: '
                      ),
                      validator: (input) => input.length < 4 ? 'You need at least 4 characters' : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description: '
                      ),
                      validator: (input) => input.length < 4 ? 'You need at least 4 characters' : null,
                      onSaved: (input) => _description = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'ImageURL: '
                      ),
                      validator: (input) => input.length < 4 ? 'You need at least 4 characters' : null,
                      onSaved: (input) => _imageurl = input,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: _submit,
                            child: Text('Submit'),
                            ),
                          )
                      ],
                    )
                  ]
                )
              )
            )
          )
      );
    }

     void _submit(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      Firestore.instance.collection('food').add(
        {
          "Name" : _name,
          "Description" : _description,
          "Image" : _imageurl,
        }
      );
    }
  }
}
