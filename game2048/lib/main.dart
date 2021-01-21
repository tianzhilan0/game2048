/*
 * @Descripttion: 
 * @version: 
 * @Author: lichuang
 * @Date: 2021-01-21 14:37:36
 * @LastEditors: lichuang
 * @LastEditTime: 2021-01-21 14:42:55
 */
import 'package:flutter/material.dart';
import 'package:game2048/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
