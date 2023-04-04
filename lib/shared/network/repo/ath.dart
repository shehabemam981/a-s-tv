import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tv/model/MyCategory.dart';
import 'package:tv/model/Search.dart';
import '../../../model/Category.dart';
import '../../../model/Results.dart';
import '../../../model/Sidesection.dart';
import '../../../model/TopMovies.dart';
import '../../../model/watchlistmodel.dart';
abstract class reposatoryath{
Future<Sidesection> sidesection();
Future<Search> search(String query);
Future<TopMovies> topmovies();
Future<Categorylist> categorylist();
Future<MyCategory> mycategorylist();
CollectionReference<Results> createcollection();
Future<void> adddatatofirebase(Results results);
Stream<QuerySnapshot<Results>> getdatafromfirebase();
Future<Box> openbox();
List<Results> getwishlist(Box box);
Future<void> addtowishlist(Box box,Results results);
Future<void> removetowishlist(Box box,Results results);

}