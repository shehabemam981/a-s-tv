
import 'package:hive/hive.dart';
import 'package:tv/base/baseViewModel.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/model/watchlistmodel.dart';
import 'package:tv/module/home2/homenavigator.dart';

import '../../model/Sidesection.dart';
import '../../model/TopMovies.dart';
import '../../shared/network/datasource/datasource.dart';
import '../../shared/network/repo/impl.dart';

class home2viewmodel extends BaseViewModel<home2navigator>{
   Results? result;

  datasource data=datasource(reposatoryimpl());
  Future<Sidesection>sidesection1(){

    try{

      return data.ath.sidesection();

  }catch(error){
    return navigator!.viewmassege(massege: "${error.toString()}");
    }
  }
  Future<TopMovies> recommended(){

    return data.ath.topmovies();
  }
    adddtohive()async{
    Results results=Results(
      id: result!.id,
      title: result!.title,
       posterPath: result!.posterPath,
    );
   Box box= await data.ath.openbox();
     data.ath.addtowishlist(box,results)
        .then((value) =>print("shehab emam saeed said"))
        .catchError((onError)=>print("${onError.toString()} shepoo"));
   notifyListeners();
  }

  removefromhive()async{
    Box box =await data.ath.openbox();
    return data.ath.removetowishlist(box, result!);
  }



}