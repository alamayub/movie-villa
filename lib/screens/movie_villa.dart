import 'package:flutter/material.dart';

class MovieVilla extends StatefulWidget {
  @override
  _MovieVillaState createState() => _MovieVillaState();
}

class _MovieVillaState extends State<MovieVilla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('Movie villa'),
        ),
      ),
    );
  }
}
