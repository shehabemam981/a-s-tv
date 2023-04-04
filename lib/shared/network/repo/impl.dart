import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tv/model/Category.dart';
import 'package:tv/model/MyCategory.dart';
import 'package:tv/model/Newrelease.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/model/Search.dart';
import 'package:tv/model/Sidesection.dart';
import 'package:tv/model/TopMovies.dart';
import 'package:tv/model/watchlistmodel.dart';
import 'package:tv/shared/componant/constants/constants.dart';
import 'package:tv/shared/network/repo/ath.dart';
import 'package:http/http.dart' as http;

class reposatoryimpl implements reposatoryath {
  @override
  Future<Sidesection> sidesection() async {
    try {
      Uri url = Uri.https(baseurl, "/3/movie/popular",
          {"api_key": apikey, "language": language, "page": "1"});
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body);
      var json = Sidesection.fromJson(jsonResponse);
      print("shehab2");
      return json;
    } catch (error) {
      print("${error.toString()}");
      rethrow;
    }
  }

//https://api.themoviedb.org/3/movie/
// top_rated?api_key=38ce7474e3afde206f8868ea1856e1e3&language=en-US&page=1
  @override
  Future<TopMovies> topmovies() async {
    try {
      var url = Uri.https(baseurl, "/3/movie/top_rated",
          {"api_key": apikey, "language": language, "page": "1"});
      var response = await http.get(url);
      var responsejson = jsonDecode(response.body);
      var json = TopMovies.fromJson(responsejson);
      return json;
    } catch (erorr) {
      rethrow;
    }
  }

//https://api.themoviedb.org/3/search/movie?
// api_key=38ce7474e3afde206f8868ea1856e1e3&language=en-US&query=query&page=1&include_adult=false
  @override
  Future<Search> search(String query) async {
    var url = Uri.https(baseurl, "/3/search/movie", {
      "api_key": apikey,
      "language": language,
      "query": query,
      "page": "1",
      "include_adult": "false"
    });
    var response = await http.get(url);
    var responseJson = jsonDecode(response.body);
    var json = Search.fromJson(responseJson);
    return json;
  }

//https://api.themoviedb.org/3/genre/movie/list?api_key=38ce7474e3afde206f8868ea1856e1e3&language=en-US
  @override
  Future<Categorylist> categorylist() async {
    var url = Uri.https(baseurl, "/3/genre/movie/list", {
      "api_key": apikey,
      "language": language,
    });
    var response = await http.get(url);
    var source = jsonDecode(response.body);
    var json = Categorylist.fromJson(source);
    return json;
  }

//https://api.themoviedb.org/3/discover/movie?
// api_key=38ce7474e3afde206f8868ea1856e1e3&language=en-US&sort_by=popularity.desc
// &include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
  @override
  Future<MyCategory> mycategorylist( )async {
    var URL = Uri.https(baseurl, "/3/discover/movie", {
      "api_key": apikey,
      "language": language,
      "sort_by": "popularity.desc",
      "include_adult": "false",
      "include_video": "false",
      "page": "1",
      "with_watch_monetization_types": "flatrate",
    });
    var rsponse= await http.get(URL);
    var responsejson=jsonDecode(rsponse.body);
    var json=MyCategory.fromJson(responsejson);
    return json;
  }

  @override
  Future<void> adddatatofirebase(Results results) {
    var collection=createcollection();
    var docref=collection.doc();
    results.id.toString()!=docref.id ;
    return docref.set(results);
  }

  @override
  CollectionReference<Results> createcollection() {
    return FirebaseFirestore.instance.collection("watchlistmodel").withConverter(
        fromFirestore: (snapshot, options) => Results.fromJson(snapshot.data()!),
        toFirestore: (value,options)=>value.toJson());
  } @override
  Future<Box> openbox() async{
    Box box=await Hive.openBox<Results>("Results");
    return box;
  }
  @override
  List<Results> getwishlist(Box box) {
    return box.values.toList() as List<Results>;
  }

  @override
  Future<void> addtowishlist(Box box, Results results)async{
   return await box.put(results.id, results);
  }

  @override
  Future<void> removetowishlist(Box box, Results results)async {
    return await box.delete(results.id);
  }
  @override
  Stream<QuerySnapshot<Results>> getdatafromfirebase() {
    return createcollection().snapshots();
  }

}
