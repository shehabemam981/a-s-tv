import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/model/Search.dart';
import 'package:tv/module/search/searchnavigator.dart';
import 'package:tv/module/search/searchviewmodel.dart';
import 'package:tv/module/search/shapeofitem.dart';
import 'package:tv/shared/styles/constants.dart';

class searchview extends StatefulWidget {


  @override
  State<searchview> createState() => _searchviewState();
}

class _searchviewState extends BaseView<searchviewmodel,searchview> implements searchnavigator{

  String query="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => model,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40,
        vertical: 50
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: opsgraycolor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                style:TextStyle(
                  color: whitecolor,
                ) ,
                cursorColor: whitecolor,
                onChanged: (value){
                  query=value;
                  setState((){});
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.grey,
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: whitecolor,
                    ),
                  ),
                  prefixIcon:Icon(Icons.search,color: whitecolor),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: whitecolor,
                    ),
                  ) ,
                  hintText:"Search",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<List<Results>>(
              future: model.search(query),
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
                return Expanded(
                  child: ListView.separated(itemBuilder: (context, index) =>
                      shapeofitem(searchitem!.elementAt(index)),
                      separatorBuilder: (context, index) =>Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: opsgraycolor,
                        ),
                      ),
                      itemCount: searchitem!.length),
                );
              },),



          ],
        ),
      ),
    );
  }

  @override
  viewmodel() {
   return searchviewmodel();

  }
}
