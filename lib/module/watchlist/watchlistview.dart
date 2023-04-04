import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/module/watchlist/watchnavigator.dart';
import 'package:tv/module/watchlist/watchviewmodel.dart';

import '../../model/Results.dart';
import '../../shared/styles/constants.dart';
import '../search/shapeofitem.dart';

class watchlistview extends StatefulWidget {
  const watchlistview({Key? key}) : super(key: key);

  @override
  State<watchlistview> createState() => _watchlistviewState();
}

class _watchlistviewState extends BaseView<watchlistviewmodel,watchlistview>implements watchnaviagator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => model,
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: blackcolor,
          title: Text("Watchlist",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: whitecolor
          ),),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<Results>>(
            future: model.getfromhive(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(child: Text("not found"));
              } else if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: whitecolor,
                  ),
                );
              }
              var searchitem = snapshot.data;
              return ListView.separated(itemBuilder: (context, index) =>
                  shapeofitem(searchitem!.elementAt(index)),
                  separatorBuilder: (context, index) =>Container(
                    height: 1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: opsgraycolor,
                    ),
                  ),
                  itemCount: searchitem!.length);
            },),
        ),

      ),
    );
  }

  @override
  viewmodel() {
    return watchlistviewmodel();
   }
}
