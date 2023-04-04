import 'package:flutter/material.dart';
import 'package:tv/model/Category.dart';
import 'package:tv/model/Genres.dart';
import 'package:tv/module/browse/mycategory.dart';

class onecategory extends StatefulWidget {
Genres cat;
onecategory(this.cat);
  @override
  State<onecategory> createState() => _onecategoryState();
}

class _onecategoryState extends State<onecategory> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset("assets/images/category.jpg",
          fit: BoxFit.fill,
        ),
        Text("${widget.cat.name}",style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
      ],
    );
  }
}
