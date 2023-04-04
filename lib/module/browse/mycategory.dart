import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Genres.dart';
import 'package:tv/model/MyCategory.dart';
import 'package:tv/module/browse/browsenavigator.dart';
import 'package:tv/module/browse/browseviewmodel.dart';

import '../../shared/styles/constants.dart';
import '../search/shapeofitem.dart';

class mycategory extends StatefulWidget {
  static const String RouteName="mycategory";

  @override
  State<mycategory> createState() => _mycategoryState();
}

class _mycategoryState extends BaseView<browseviewmodel,mycategory>
    implements browsenavigator {

  @override
  void initState() {
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    var pro=ModalRoute.of(context)?.settings.arguments as Genres;
    return ChangeNotifierProvider(
      create:(context)=>model,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${pro.name}",style: TextStyle(
                color: whitecolor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
             FutureBuilder<MyCategory>(
               future: model.mycategorymodel(),
               builder: (context, snapshot) {
                 if (snapshot.hasError) {
                   return Center(child: Text("not found"));
                 } else if (snapshot.connectionState ==
                     ConnectionState.waiting) {
                   return CircularProgressIndicator();
                 }
                 var cat=snapshot.data?.results??[];
                 return Expanded(
                   child: ListView.separated(itemBuilder: (context, index) =>
                       shapeofitem(cat[index]),
                       separatorBuilder: (context, index) =>Container(
                         height: 1,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           color: opsgraycolor,
                         ),
                       ),
                       itemCount: cat.length),
                 );
               }),
                 ]
             )

          ),
      ),

    );
  }

  @override
  viewmodel() {
  return browseviewmodel();
  }
}
