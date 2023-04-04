import 'package:tv/base/baseViewModel.dart';
import 'package:tv/base/basenavigator.dart';
import 'package:tv/model/Genres.dart';
import 'package:tv/shared/network/datasource/datasource.dart';
import 'package:tv/shared/network/repo/impl.dart';

import '../../model/Category.dart';

class browseviewmodel extends BaseViewModel<BaseNavigator>{
datasource data=datasource(reposatoryimpl());
Genres? selecteditem=null;
 category(){
  return data.ath.categorylist();
}
mycategorymodel(){
  return data.ath.mycategorylist();

}

}