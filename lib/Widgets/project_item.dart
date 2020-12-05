import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final int id;
  final String title;
  final double price;

  ProjectItem(
    this.id,
    this.title,
    this.price,
  );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Text('$id',style: TextStyle(fontSize: 18,color: Colors.black,),),
        title: Text(title,style: TextStyle(fontSize: 18,color: Colors.black,),),
        trailing: Text('$price\\-',style: TextStyle(fontSize: 18,color: Colors.black,),),
      ),
    );
  }
}