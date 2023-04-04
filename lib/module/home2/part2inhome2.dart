import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Newrelease.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/module/home2/home2viewmodel.dart';
import 'package:tv/module/home2/homenavigator.dart';

import '../../shared/styles/constants.dart';

class part2inhome2 extends StatefulWidget {
  Results news;
  part2inhome2(this.news);

  @override
  State<part2inhome2> createState() => _part2inhome2State();
}

class _part2inhome2State extends BaseView<home2viewmodel,part2inhome2>implements home2navigator {
  bool bookmarkl=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Column(
        children: [

          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blackcolor.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: CachedNetworkImage(
                  height:230,
                  width: 150,
                  fit: BoxFit.fill,

                  imageUrl: "https://image.tmdb.org/t/p/w500/${widget.news.posterPath}",
                  placeholder: (context, url) => Center(child: Center(child: CircularProgressIndicator(
                    color: whitecolor,
                  ))),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              IconButton(
                icon:(bookmarkl)? InkWell(
                    onTap: (){
                      model.adddtohive()!;
                      setState((){ bookmarkl=false;});
                    },
                    child: Icon(Icons.bookmark,color: graycolor,size: 30,)):
                InkWell(
                    onTap: (){
                      model.removefromhive()!;
                      setState((){ bookmarkl=true;});
                    },
                    child: Icon(Icons.bookmark,color: selectedcolor,size: 30,)),
                onPressed: () {


                },),

            ],
          ),
        ],
      ),
    );
  }

  @override
  viewmodel() {
  return home2viewmodel();
  }
}
