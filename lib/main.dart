import 'package:flutter/material.dart';
import 'package:luminis/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("The Luminis Shoe Store"),
        ),
        body: ProductList(),
      ),
    );
  }
}