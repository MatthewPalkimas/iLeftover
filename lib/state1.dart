import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

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
  File _storedImage;
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
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                       Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(width:1, color: Colors.black),
                        ),
                        child: _storedImage != null
                        ? Image.file(
                          _storedImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                        : Text('No Image Selected', textAlign: TextAlign.center,),
                        alignment: Alignment.center,
                      ),
                    
                        FlatButton.icon(
                          icon: Icon(Icons.camera), 
                          label: Text('Take Picture'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed:(){ _takePicture(context);} ,
                          ),
                          
                           
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Food Name: ',  
                        ),
                        onChanged: (text){_name=text;},
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Description: ',
                        ),
                        onChanged: (text){_description=text;},
                      ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: (){
                                _submit(context);
                              },
                              child: Text('Submit'),
                              ),
                            )
                        ],
                      )
                    ]
                  )
                )
              ),
            ],
          )
      );
    }

     void _submit(BuildContext context) async{
      Firestore.instance.collection('food').add(
        {
          "Name" : _name,
          "Description" : _description,
          "Image" : _imageurl,
        }
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
