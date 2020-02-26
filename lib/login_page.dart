import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
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
          AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          print("Signed in: ${user.user.uid}");
        }
        else {
          AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          print("Signed in: ${user.user.uid}");
        }
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
        appBar: new AppBar(
          title: new Text('Food Savior Login'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: new Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('Assets/foodtrans.jpg'),
            fit: BoxFit.cover,
          ),
        ),
          padding: EdgeInsets.all(16.0),
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
            )
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
            )
        ];
      }
    }
}