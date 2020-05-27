import 'package:flutter/material.dart';
import 'HomePage.dart';


void main()
{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
      (
      title: "Tasty Food Stuff",
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
       //home:HomePage(),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:(context) => HomePage(),
      },
    );
  }
}