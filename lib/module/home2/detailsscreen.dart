import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/module/home2/home2viewmodel.dart';
import 'package:tv/module/home2/homenavigator.dart';
import 'package:tv/module/home2/part3inhome2.dart';
import 'package:tv/shared/styles/constants.dart';

import '../../model/TopMovies.dart';

class detailsscreen extends StatefulWidget {
static const String RouteName="";
  @override
  State<detailsscreen> createState() => _detailsscreenState();
}

class _detailsscreenState extends BaseView<home2viewmodel,detailsscreen>implements home2navigator {
 bool bookmarkl=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    var pro=ModalRoute.of(context)?.settings.arguments as Results;
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
       appBar: AppBar(
         backgroundColor: opsgraycolor,
         title: Text("${pro.title}",style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 30,
           color: whitecolor
         ),),
         centerTitle: true,
       ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.fitWidth,
              width: double.infinity,
              imageUrl: "https://image.tmdb.org/t/p/w500/${pro.backdropPath}",
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${pro.title}",style: TextStyle(
                      color: whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  SizedBox(height: 5,),
                  Text("${pro.releaseDate}",style: TextStyle(
                    color: Colors.white70,
                  ),),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Container(
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
                            child: CachedNetworkImage(
                              height:210,
                              width: 150,
                              fit: BoxFit.fill,

                              imageUrl: "https://image.tmdb.org/t/p/w500/${pro.posterPath}",
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
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
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                          Text("${pro.overview}",style: TextStyle(
                            color: whitecolor,
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: selectedcolor,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("${pro.voteAverage}",style: TextStyle(
                                  color: whitecolor,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: opsgraycolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("More Like This",style: TextStyle(
                    color: whitecolor,
                    fontSize: 20,
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<TopMovies>(
                      future: model.recommended(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text("not found"));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: whitecolor,
                            ),
                          );
                        }
                        var top = snapshot.data?.results ?? [];
                        return  CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            scrollPhysics: PageScrollPhysics(),
                            viewportFraction: 0.3,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount: top.length,
                          itemBuilder: (context, index, index1) =>
                              InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, detailsscreen.RouteName,
                                      arguments: Results(
                                        posterPath: top[index].posterPath,
                                        title: top[index].title,
                                        backdropPath: top[index].backdropPath,
                                        overview: top[index].overview,
                                        releaseDate: top[index].releaseDate,
                                        voteAverage: top[index].voteAverage,
                                        genreIds: top[index].genreIds,
                                      ),
                                    );
                                  },
                                  child: part3inhome2(top[index])),
                        );
                      }),
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
  }
}
