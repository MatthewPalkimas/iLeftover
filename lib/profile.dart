import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.auth, this.onSignedOut, this.goBack});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback goBack;

  @override
  State<StatefulWidget> createState() => new _ProfilePagePageState();
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class _ProfilePagePageState extends State<ProfilePage>{
  String _name, _description, _imageurl;
  File _storedImage;
  var _foodcategory;
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  final formKey = GlobalKey<FormState>();




   Future <void> _takePicture(BuildContext context) async {
     final imageFile = await ImagePicker.pickImage(
       source: ImageSource.camera,
       );
     setState(() {
      _storedImage = imageFile;
      });
      _uploadImage(context);
   }
   
   void  _onClear() {
    setState(() {
      _textFieldController1.clear();
      _textFieldController2.clear();
      _storedImage = null;
    });
  }
   


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
          body: Column(
            children: <Widget>[
              SizedBox(width:10, height:10),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                   // mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                       Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width:1, color: Colors.black),
                        ),
                        child: _storedImage != null
                        ? Image.file(
                          _storedImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                        : Image(image: AssetImage("Assets/palk.jpg"), height: 155.0),
                        alignment: Alignment.center,
                      ),
                    
                        FlatButton.icon(
                          icon: Icon(Icons.camera), 
                          label: Text('Modify Profile Picture'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed:(){ _takePicture(context);} ,
                          ),
                          
                        SizedBox(height:10,),
                    
                      TextField(
                        controller: _textFieldController1,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                        ),
                      ),
                      TextField(
                        controller: _textFieldController2,
                        decoration: InputDecoration(
                          labelText: 'Favorite Foods: ',
                        ),
                      ),
                      TextField(
                        controller: _textFieldController3,
                        decoration: InputDecoration(
                          labelText: 'Zipcode Location: ',
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 70.0)),
                       Align(
                         alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                           onPressed: () {},
                           child: Text('Edit Profile'),
                           ),
                       )
                    ]
                  )
                )
              ),
            ],
          )
      );
    }

     void _submitconfirm(BuildContext context) async{
      Firestore.instance.collection('food').add(
        {
          "Name" : _name,
          "Description" : _description,
          "Image" : _imageurl,
        }
      );
     }
      Future <void> _submit(BuildContext context) async{
        _name = _textFieldController1.text;
        _description = _textFieldController2.text;
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Color(0xFFCAE1FF),
            title: Text('Confirm Submission?', textAlign: TextAlign.center,),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  child: Text('Yes'),
                  backgroundColor: Colors.green[100],
                  onPressed:(){ 
                    _submitconfirm(context);
                    Navigator.of(context).pop();
                    _onClear();
                    }
                  ),
                FloatingActionButton(
                  child: Text('No'),
                  backgroundColor: Colors.red[100],
                  onPressed:(){ Navigator.of(context).pop();}
                  ),
              ],
            ),
          );

        },
      );
    }

  Future <void> _uploadImage(BuildContext context) async {
   String filName = basename(_storedImage.path);
   final StorageReference ref = FirebaseStorage.instance.ref().child(filName);
   final StorageUploadTask uploadTask = ref.putFile(_storedImage);
   var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    _imageurl = dowurl.toString();
    print(_imageurl);
   } 

}
