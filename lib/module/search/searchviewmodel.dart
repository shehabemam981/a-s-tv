import 'package:tv/base/baseViewModel.dart';
import 'package:tv/model/Results.dart';
import 'package:tv/module/search/searchnavigator.dart';
import 'package:tv/shared/network/datasource/datasource.dart';

import '../../shared/network/repo/impl.dart';

class searchviewmodel extends BaseViewModel<searchnavigator>{
  datasource data=datasource(reposatoryimpl());
  List<Results> result=[];
 Future<List<Results>> search(String query){
    return data.ath.search(query).then((value) =>
     result=value.results??[],
    ).catchError((onError)=>"$onError");

  }
}