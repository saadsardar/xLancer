import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('messages'),centerTitle: true,),
      body: Center(
        child: Text('this is my message screen page'),
      ),
    );
  }
}