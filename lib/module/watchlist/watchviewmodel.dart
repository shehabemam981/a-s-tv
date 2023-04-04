import 'package:hive/hive.dart';
import 'package:tv/base/baseViewModel.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/module/watchlist/watchnavigator.dart';
import 'package:tv/shared/network/datasource/datasource.dart';
import 'package:tv/shared/network/repo/impl.dart';

class watchlistviewmodel extends BaseViewModel<watchnaviagator>{
  datasource data=datasource(reposatoryimpl());
 Future<List<Results>> getfromhive()async{
    Box box= await data.ath.openbox();
    return data.ath.getwishlist(box);
  }
}