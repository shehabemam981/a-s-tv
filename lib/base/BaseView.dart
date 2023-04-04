import 'package:flutter/material.dart';
import 'package:tv/base/baseViewModel.dart';
import 'package:tv/base/basenavigator.dart';

abstract class BaseView<vm extends BaseViewModel,t extends StatefulWidget> extends State<t>
implements BaseNavigator{
late vm model;
 viewmodel();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model=viewmodel();
  }
  @override
  hideanything() {
 Navigator.pop(context);
  }

  @override
  viewdialog(String massege,String title,
      ) {

     showDialog(context: context, builder:(context){
       return AlertDialog(
         title: Text(title),
         content: Text(massege),
         

       );
     } );
  }

  @override
  viewmassege({String massege="loading"}) {
   showDialog(context: context, builder: (context){
     return AlertDialog(
      content: Column(
        children: [
          CircularProgressIndicator(),
          Text(massege),
        ],
      ),
     );
   });
  }


}