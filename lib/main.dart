import 'package:flutter/material.dart';
import './firstPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini',
      theme: ThemeData(
        fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
        primarySwatch: Colors.blue,accentColor: Color(0xffFF4081)
      ),
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

