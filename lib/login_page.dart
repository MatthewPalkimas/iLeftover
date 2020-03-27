import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        }
        else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print("Signed in: $userId");
        }
        widget.onSignedIn();
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(25.0, 200.0, 25.0, 0.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          ),
        )
      );
    }

    List<Widget> buildInputs(){
      return [
          Image.asset(
            'Assets/LOGO.png',
            width: 200,
            height: 100,
            fit: BoxFit.contain,
          ),
            // new Text("iLeftover", style: new TextStyle(
            //             color: Color(0xFF139427), 
            //             fontSize: 90.0,
            //             shadows: [
            //               Shadow( // bottomLeft
            //                 offset: Offset(-2, -2),
            //                 color: Color(0xFF0ea4b5)
            //               ),
            //               Shadow( // bottomRight
            //                 offset: Offset(2, -2),
            //                 color: Color(0xFF0ea4b5)
            //               ),
            //               Shadow( // topRight
            //                 offset: Offset(2, 2),
            //                 color: Color(0xFF0ea4b5)
            //               ),
            //               Shadow( // topLeft
            //                 offset: Offset(-2, 2),
            //                 color: Color(0xFF0ea4b5)
            //               ),
            //             ])
            // ),
            new TextFormField(
              decoration: new InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                //  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                labelText: 'Email',
              ),
              validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => _email = value,
            ),
            new TextFormField(
              decoration: new InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
            //      fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                labelText: 'Password',
                ),
              validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
              obscureText: true,
              onSaved: (value) => _password = value,
            ),
      ];
    }

    List<Widget> buildSubmitButtons() {
      if (_formType == FormType.login) 
      {
        return [                
            new RaisedButton(
              child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
              onPressed: validateAndSubmit,
            ),
            new RaisedButton(
              child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
              onPressed: moveToRegister,
            ),
            _signInButton()
        ];
      } else {
        return [
            new RaisedButton(
              child: new Text('Create an Account', style: new TextStyle(fontSize: 20.0)),
              onPressed: validateAndSubmit,
            ),
            new RaisedButton(
              child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20.0)),
              onPressed: moveToLogin,
            ),
        ];
      }
    }
  Widget _signInButton() {
    return new Row(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(left: 60.0, top: 20.0),
          alignment: Alignment.center,
          child: new OutlineButton(
            splashColor: Colors.green,
            onPressed: () {
              widget.auth.signInWithGoogle().whenComplete(() {
                widget.onSignedIn();
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("Assets/google_logo.png"), height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        )
      ],
    );
  }
}