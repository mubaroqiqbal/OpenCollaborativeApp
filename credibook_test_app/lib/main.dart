import 'package:flutter/material.dart';
import 'package:credibook_test_app/view/home/home.dart';


main(){

  runApp(
    MaterialApp(
      title: 'Github',
      theme: ThemeData(
          fontFamily: 'Lato',
          appBarTheme: AppBarTheme(
              brightness: Brightness.light
          )
      ),
      home: Home(),
    ),
  );
}
