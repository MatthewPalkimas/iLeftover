import 'package:flutter/material.dart';
import 'package:food_savior/auth.dart';
import 'auth.dart';
import 'root.dart';

void main()
{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget
{
  @override
    Widget build(BuildContext context) {
      
      return new MaterialApp(
        title: 'Food Savior Login',
        theme: new ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: new RootPage(auth: new Auth())
      );
    }
}