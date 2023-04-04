import 'package:flutter/material.dart';
import 'package:tv/model/Results.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv/shared/styles/constants.dart';

class shapeofitem extends StatelessWidget {
  Results res;

  shapeofitem(this.res);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 180,
            fit: BoxFit.fill,
            height: 100,
            imageUrl: "https://image.tmdb.org/t/p/w500/${res.backdropPath!}",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${res.title}",style: TextStyle(
                  color: whitecolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(height: 10,),
                Text("${res.releaseDate}",style: TextStyle(
                  color: Colors.white70,
                ),),
                Text("${res.overview}", style: TextStyle(
                  color:  Colors.white70,
                ),overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star,color: selectedcolor,),
                    Text("${res.voteAverage}",style: TextStyle(
                      color: Colors.white70,
                    ),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
