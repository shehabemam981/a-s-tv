import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/module/home2/home2viewmodel.dart';
import 'package:tv/module/home2/homenavigator.dart';

import '../../model/Results.dart';
import '../../shared/styles/constants.dart';

class part1inhome2 extends StatefulWidget {

  Results res;
  part1inhome2(this.res);

  @override
  State<part1inhome2> createState() => _part1inhome2State();
}

class _part1inhome2State extends BaseView<home2viewmodel,part1inhome2>implements home2navigator {

  bool bookmark = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>model,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20),
         child: Column(
          children: [
            Stack(
                alignment: AlignmentDirectional.bottomStart,
                fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CachedNetworkImage(
                       fit: BoxFit.fitWidth,
                        width: double.infinity,
                        imageUrl: "https://image.tmdb.org/t/p/w500/${widget.res.backdropPath!}",
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(
                          color: whitecolor,
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.play_circle),
                        iconSize: 100,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 30,
                    top: 250,
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                        BoxShadow(
                        color: selectedcolor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                          ]
                  ),
                        child: Row(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                CachedNetworkImage(
                                  height:200,
                                  width: 150,
                                  fit: BoxFit.fill,
                                  imageUrl: "https://image.tmdb.org/t/p/w500/${widget.res.posterPath!}",
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(
                                    color: whitecolor,
                                  )),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                IconButton(
                                  icon:(bookmark)? InkWell(
                                      onTap: (){

                                        setState((){ bookmark=false;});
                                      },
                                      child: Icon(Icons.bookmark,color: graycolor,size: 30,)):
                                  InkWell(
                                      onTap: (){

                                        bookmark=true;
                                        setState((){ });
                                      },
                                      child: Icon(Icons.bookmark,color: selectedcolor,size: 30,)),
                                  onPressed: () {
                                  },),

                              ],
                            ),
                          ]
                        )
                    ),
                  ),
                ],
              ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 200,
                vertical: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.res.title ?? "",
                    style: TextStyle(
                        color: whitecolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.res.releaseDate ?? "",
                    style: TextStyle(
                      color: graycolor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  viewmodel() {
   return home2viewmodel();
  }}
// Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(widget.res.title??"" ,style: TextStyle(
// color: whitecolor,
// fontWeight: FontWeight.bold,
// fontSize: 20
// ),),
// SizedBox(
// height: 5,
// ),
// Text(widget.res.releaseDate??"",style: TextStyle(
// color: graycolor,
// ),),
// ],
// ),
// ),