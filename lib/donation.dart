import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DonationPageState();
}

class _DonationPageState extends State<DonationPage>
{
  @override
    Widget build(BuildContext context)
    {
      return new Material(
          child: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('Assets/wood-texture.jpg'),
              fit: BoxFit.cover,
              ),
            ),
            child: new Container(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: 140.0)),
                      new Text(
                         'Donate Food in Your Area',
                          style: new TextStyle(color: Colors.green, fontSize: 25.0),
                      ),
                      new Padding(
                         padding: EdgeInsets.only(top: 50.0)
                      ),
                    ],
                  )
              ),
            )
          ),
      );
    }
}