import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Category.dart';
import 'package:tv/model/Genres.dart';
import 'package:tv/module/browse/browseviewmodel.dart';
import 'package:tv/module/browse/mycategory.dart';
import 'package:tv/shared/styles/constants.dart';

import 'onecategory.dart';

class browseview extends StatefulWidget {
  @override
  State<browseview> createState() => _browseviewState();
}

class _browseviewState extends BaseView<browseviewmodel,browseview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Browse Category",style: TextStyle(
              color: whitecolor,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),),
            FutureBuilder<Categorylist>(
              future: model.category(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("not found"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var categories=snapshot.data?.genres??[];
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 4,
                      childAspectRatio: 2,
                    ),
                    itemBuilder:(context,index)=>InkWell(
                        onTap: (){

                          setState((){});
                          Navigator.pushNamed(context, mycategory.RouteName,
                          arguments: Genres(
                            name: categories[index].name,
                          ),
                          );
                        },
                        child: onecategory(categories[index])) ,
                    itemCount: categories.length,

                  ),
                );

            },
            ),

          ],
        ),
      ),
    );
  }


  @override
  viewmodel() {
    return browseviewmodel();
  }
}
