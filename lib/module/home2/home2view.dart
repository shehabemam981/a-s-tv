import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Newrelease.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/model/Sidesection.dart';
import 'package:tv/model/TopMovies.dart';
import 'package:tv/module/home2/detailsscreen.dart';
import 'package:tv/module/home2/homenavigator.dart';
import 'package:tv/module/home2/part1inhome2.dart';
import 'package:tv/module/home2/part2inhome2.dart';
import 'package:tv/module/home2/part3inhome2.dart';

import '../../shared/styles/constants.dart';
import 'home2viewmodel.dart';

class home2view extends StatefulWidget {
  @override
  State<home2view> createState() => _home2viewState();
}

class _home2viewState extends BaseView<home2viewmodel, home2view>
    implements home2navigator {
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<Sidesection>(
              future: model.sidesection1(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("not found"));
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: whitecolor,
                    ),
                  );
                }
                var side1 = snapshot.data?.results ?? [];
                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 500,
                    aspectRatio: 16 / 9,
                    padEnds: false,
                    scrollPhysics: PageScrollPhysics(),
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeFactor: 0.9,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: side1.length,
                  itemBuilder: (context, index, index1) =>
                      InkWell(
                          onTap: (){

                            Navigator.pushNamed(context, detailsscreen.RouteName,
                              arguments: Results(
                                posterPath: side1[index].posterPath,
                                title: side1[index].title,
                                backdropPath: side1[index].backdropPath,
                                overview: side1[index].overview,
                                releaseDate: side1[index].releaseDate,
                                voteAverage: side1[index].voteAverage,
                                genreIds: side1[index].genreIds,
                              ),
                            );
                          },
                          child: part1inhome2(side1[index])),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: opsgraycolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News Release",
                    style: TextStyle(
                      color: whitecolor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Sidesection>(
                    future: model.sidesection1(),
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
                      var latest = snapshot.data?.results ?? [];
                      print("${snapshot.data?.results}");
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Container(
                            color: opsgraycolor,
                            child: SizedBox(
                              width: 20,
                            ),
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: latest.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context, detailsscreen.RouteName,
                                    arguments: Results(
                                      posterPath: latest[index].posterPath,
                                        title: latest[index].title,
                                      backdropPath: latest[index].backdropPath,
                                      overview: latest[index].overview,
                                      releaseDate: latest[index].releaseDate,
                                      voteAverage: latest[index].voteAverage,
                                      genreIds: latest[index].genreIds,
                                    ),
                                  );
                                },
                                child: part2inhome2(latest[index]));

                          }),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: opsgraycolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recommended",style: TextStyle(
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
