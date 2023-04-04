import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv/model/Results.dart';

import '../../shared/styles/constants.dart';

class part3inhome2 extends StatefulWidget {
  Results res;
  part3inhome2(this.res);

  @override
  State<part3inhome2> createState() => _part3inhome2State();
}

class _part3inhome2State extends State<part3inhome2> {
  var bookmarkl=true;
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
        color: opsgraycolor,
          boxShadow: [
            BoxShadow(
              color: blackcolor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                CachedNetworkImage(
                  height:230,
                  width: 150,
                  fit: BoxFit.fill,

                  imageUrl: "https://image.tmdb.org/t/p/w500/${widget.res.posterPath}",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(
                    color: whitecolor,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                IconButton(
                  icon:(bookmarkl)? InkWell(
                      onTap: (){
                        setState((){ bookmarkl=false;});
                      },
                      child: Icon(Icons.bookmark,color: graycolor,size: 30,)):
                  InkWell(
                      onTap: (){
                        setState((){ bookmarkl=true;});
                      },
                      child: Icon(Icons.bookmark,color: selectedcolor,size: 30,)),
                  onPressed: () {},),
              ],
            ),

            Text("${widget.res.title}",style: TextStyle(
              color: whitecolor,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.star,color: selectedcolor,),
                SizedBox(
                  width: 5,
                ),
                Text("${widget.res.voteAverage}",style: TextStyle(
                  color: whitecolor,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
